require 'rails_helper'

RSpec.describe ProjectSubmission do
  subject(:project_submission) { create(:project_submission) }

  it_behaves_like 'likeable', :project_submission

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:lesson) }
  it { is_expected.to have_many(:flags) }

  it { is_expected.to validate_presence_of(:repo_url).with_message('Required') }
  it { is_expected.to allow_value('http://www.github.com/fff').for(:repo_url) }
  it { is_expected.to allow_value('https://www.github.com/fff').for(:repo_url) }
  it { is_expected.not_to allow_value('not_a_url').for(:repo_url) }

  it { is_expected.to allow_value('http://www.github.com/fff').for(:live_preview_url) }
  it { is_expected.to allow_value('https://www.github.com/fff').for(:live_preview_url) }
  it { is_expected.not_to allow_value('not_a_url').for(:live_preview_url) }

  it do
    expect(project_submission).to validate_uniqueness_of(:user_id)
      .scoped_to(:lesson_id)
      .with_message('You have already submitted a project for this lesson')
  end

  context 'when live preview is not allowed' do
    subject(:project_submission) do
      build(:project_submission, lesson: create(:lesson, previewable: false))
    end

    it do
      expect(project_submission).not_to allow_value('http://www.github.com/fff')
        .for(:live_preview_url)
        .with_message('Live preview is not allowed for this project')
    end
  end

  describe '.only_public' do
    it 'returns public project submissions that have not been discarded' do
      public_project_submission_one = create(:project_submission)
      public_project_submission_two = create(:project_submission)
      create(:project_submission, is_public: false)
      create(:project_submission, discarded_at: Time.zone.today)

      expect(described_class.only_public).to contain_exactly(
        public_project_submission_one,
        public_project_submission_two
      )
    end
  end

  describe '.not_removed_by_admin' do
    it 'returns project submissions that have not been discarded' do
      not_discarded_project_submission = create(:project_submission)
      create(:project_submission, discarded_at: Time.zone.today)
      create(:project_submission, discarded_at: Time.zone.today)

      expect(described_class.not_removed_by_admin).to contain_exactly(
        not_discarded_project_submission
      )
    end
  end

  describe '.created_today' do
    it 'returns projects submission created today' do
      project_submission_created_today = create(
        :project_submission,
        created_at: Time.zone.today
      )

      project_submission_not_not_created_today = create(
        :project_submission,
        created_at: Time.zone.today - 2.days
      )

      expect(described_class.created_today).to contain_exactly(project_submission_created_today)
    end
  end

  describe '.discardable' do
    context 'when the project submission discard_at date is in the past' do
      it 'returns a list including the project submission' do
        project_submission = create(:project_submission, discard_at: 8.days.ago)

        expect(described_class.discardable).to include(project_submission)
      end
    end

    context 'when the project submission discard_at date is in the future' do
      it 'returns a list not including the project submission' do
        project_submission = create(:project_submission, discard_at: 1.day.from_now)

        expect(described_class.discardable).not_to include(project_submission)
      end
    end

    context 'when the project submission discard_at date is today' do
      it 'returns a list including the project submission' do
        project_submission = create(:project_submission, discard_at: 5.minutes.ago)

        expect(described_class.discardable).to include(project_submission)
      end
    end

    context 'when the project submission discard_at date is nil' do
      it 'returns a list not including the project submission' do
        project_submission = create(:project_submission, discard_at: nil)

        expect(described_class.discardable).not_to include(project_submission)
      end
    end

    context 'when the project_submission has been removed by admin' do
      it 'returns a list not including the project submission' do
        project_submission = create(
          :project_submission,
          discarded_at: 10.days.ago,
          discard_at: 6.days.ago
        )

        expect(described_class.discardable).not_to include(project_submission)
      end
    end
  end

  describe '.sort_by_params' do
    context "when sorting by 'created_at'" do
      it 'returns a list of project submissions sorted by created_at desc' do
        newest = create(:project_submission, created_at: 1.day.ago)
        last_week = create(:project_submission, created_at: 1.week.ago)
        oldest = create(:project_submission, created_at: 2.weeks.ago)

        expect(described_class.sort_by_params('created_at')).to eq(
          [newest, last_week, oldest]
        )
      end
    end

    context "when sorting by 'created_at' asc" do
      it 'returns a list of project submissions sorted by created_at ascending' do
        newest = create(:project_submission, created_at: 1.day.ago)
        last_week = create(:project_submission, created_at: 1.week.ago)
        oldest = create(:project_submission, created_at: 2.weeks.ago)

        expect(described_class.sort_by_params('created_at', 'asc')).to eq(
          [oldest, last_week, newest]
        )
      end
    end

    context "when sorting by 'likes_count'" do
      it 'returns a list of project submissions sorted by likes_count' do
        most_likes = create(:project_submission, likes_count: 10)
        some_likes = create(:project_submission, likes_count: 5)
        no_likes = create(:project_submission, likes_count: 0)

        expect(described_class.sort_by_params('likes_count')).to eq(
          [most_likes, some_likes, no_likes]
        )
      end
    end

    context 'when sort column is not allowed' do
      it 'defaults to sorting by created_at' do
        newest = create(:project_submission, created_at: 1.day.ago)
        last_week = create(:project_submission, created_at: 1.week.ago)
        oldest = create(:project_submission, created_at: 2.weeks.ago)

        expect(described_class.sort_by_params('updated_at')).to eq(
          [newest, last_week, oldest]
        )
      end
    end
  end

  describe '.before_update callback' do
    let(:discardable_project_submission) { create(:project_submission, discard_at: discard_date) }
    let(:discard_date) { DateTime.new(2021, 9, 1) }

    context 'when the repo url is being updated' do
      it 'sets discard_at to nil' do
        repo_url = 'https://www.legitrepo.com'

        discardable_project_submission.update(repo_url:)

        expect(discardable_project_submission.reload.discard_at).to be_nil
      end
    end

    context 'when the live_preview_url is being updated' do
      it 'sets discard_at to nil' do
        live_preview_url = 'https://legitlivepreview.com'

        discardable_project_submission.update(live_preview_url:)

        expect(discardable_project_submission.reload.discard_at).to be_nil
      end
    end

    context 'when any other attribute is updated' do
      it 'does not modify update at' do
        discardable_project_submission.update(is_public: false)

        expect(discardable_project_submission.reload.discard_at).to eq(discard_date)
      end
    end
  end

  describe '#sortable_columns' do
    it 'returns an array of sortable columns' do
      expect(described_class.sortable_columns).to eq(%w[created_at likes_count])
    end
  end
end
