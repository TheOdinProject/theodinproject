require 'rails_helper'

RSpec.describe User do
  subject(:user) { create(:user) }

  it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
  it { is_expected.to allow_value('example@email.com').for(:email) }
  it { is_expected.not_to allow_value('bademail').for(:email) }
  it { is_expected.to validate_length_of(:username).is_at_least(2).is_at_most(100) }
  it { is_expected.to validate_length_of(:learning_goal).is_at_most(1700) }

  it { is_expected.to have_many(:lesson_completions).dependent(:destroy) }
  it { is_expected.to have_many(:completed_lessons) }
  it { is_expected.to have_many(:project_submissions).dependent(:destroy) }
  it { is_expected.to have_many(:user_providers).dependent(:destroy) }
  it { is_expected.to have_many(:flags).dependent(:destroy) }
  it { is_expected.to have_many(:notifications) }
  it { is_expected.to have_many(:likes).dependent(:destroy) }
  it { is_expected.to have_many(:interview_surveys).dependent(:destroy) }
  it { is_expected.to belong_to(:path).optional(true) }

  context 'when user is created' do
    let!(:default_path) { create(:path, default_path: true) }

    it 'enrolls the user in the default path' do
      user = create(:user)
      expect(user.path).to eql(default_path)
    end
  end

  describe '.signed_up_on' do
    it 'returns users who signed up on a given date' do
      user_signed_up_yesterday = create(:user, created_at: Time.zone.yesterday)
      create(:user, created_at: Time.zone.today)
      create(:user, created_at: Time.zone.tomorrow)
      create(:user, created_at: Time.zone.yesterday - 1.day)

      expect(described_class.signed_up_on(Time.zone.yesterday)).to contain_exactly(user_signed_up_yesterday)
    end
  end

  describe '.banned' do
    it 'returns banned users' do
      first_banned_user = create(:user, banned: true)
      second_banned_user = create(:user, banned: true)
      create(:user, banned: false)
      create(:user, banned: false)

      expect(described_class.banned).to contain_exactly(
        first_banned_user, second_banned_user
      )
    end
  end

  describe '.search_by' do
    it 'only returns users whose username or email matches the search term' do
      barry = create(:user, username: 'Barry', email: 'barry@email.com')
      alice = create(:user, username: 'Alice', email: 'alice@email.com')
      bartholomew = create(:user, username: 'Bat', email: 'bartholomew@email.com')

      expect(described_class.search_by('Bar')).to contain_exactly(barry, bartholomew)
    end

    context "when the search term doesn't match any users" do
      it 'returns an empty array' do
        create(:user, username: 'Barry')
        create(:user, username: 'Alice')

        expect(described_class.search_by('Z')).to be_empty
      end
    end
  end

  describe '#progress_for' do
    let(:course) { build_stubbed(:course) }
    let(:course_progress) { instance_double(CourseProgress) }

    before do
      allow(CourseProgress).to receive(:new).and_return(course_progress)
    end

    it 'returns the course progress service' do
      expect(user.progress_for(course)).to eql(course_progress)
    end
  end

  describe '#completed?' do
    let(:lesson) { create(:lesson) }

    context 'when the user has completed the lesson' do
      it 'returns true' do
        create(:lesson_completion, lesson:, user:)

        expect(user.completed?(lesson)).to be(true)
      end
    end

    context 'when the user has not completed the lesson' do
      it 'returns false' do
        expect(user.completed?(lesson)).to be(false)
      end
    end
  end

  describe '#latest_completed_lesson' do
    let(:lesson_completed_last_week) { create(:lesson) }
    let(:lesson_completed_yesterday) { create(:lesson) }
    let(:lesson_completed_today) { create(:lesson) }

    context 'when the user has completed any lessons' do
      before do
        create(
          :lesson_completion,
          lesson: lesson_completed_last_week,
          user:,
          created_at: Time.zone.today - 7.days
        )

        create(
          :lesson_completion,
          lesson: lesson_completed_yesterday,
          user:,
          created_at: Time.zone.today - 1.day
        )

        create(
          :lesson_completion,
          lesson: lesson_completed_today,
          user:,
          created_at: Time.zone.today
        )
      end

      it 'returns the latest completed lesson' do
        expect(user.latest_completed_lesson).to eql(lesson_completed_today)
      end
    end

    context 'when the user does not have any completed lessons' do
      it 'returns nil' do
        expect(user.latest_completed_lesson).to be_nil
      end
    end
  end

  describe '#lesson_completions_for_course' do
    it 'returns the users lesson completions for a course' do
      create(:lesson_completion, user:)
      course = create(:course)
      lesson_completion_one_for_course = create(:lesson_completion, course_id: course.id, user:)
      lesson_completion_two_for_course = create(:lesson_completion, course_id: course.id, user:)

      expect(user.lesson_completions_for_course(course)).to contain_exactly(
        lesson_completion_one_for_course, lesson_completion_two_for_course
      )
    end
  end

  describe '#active_for_authentication?' do
    context 'when user has not been banned' do
      let(:user) { create(:user) }

      it 'returns true' do
        expect(user.active_for_authentication?).to be(true)
      end
    end

    context 'when user has been banned' do
      let(:user) { create(:user, banned: true) }

      it 'returns false' do
        expect(user.active_for_authentication?).to be(false)
      end
    end
  end

  describe '#inactive_message' do
    context 'when user has not been banned' do
      let(:user) { create(:user) }

      it 'returns default inactive translation key' do
        expect(user.inactive_message).to eq(:inactive)
      end
    end

    context 'when user has been banned' do
      let(:user) { create(:user, banned: true) }

      it 'returns banned translation key' do
        expect(user.inactive_message).to eq(:banned)
      end
    end
  end

  describe '#dismissed_flags' do
    it 'returns flags the user has made that have been dismissed' do
      non_dismissed_flag = create(:flag, flagger: user, action_taken: :ban)
      dismissed_flag = create(:flag, flagger: user, action_taken: :dismiss)

      expect(user.dismissed_flags).to contain_exactly(dismissed_flag)
    end
  end

  describe '#started_course?' do
    let(:course) { create(:course) }

    context 'when the user has started the course' do
      it 'returns true' do
        lesson_completion = create(:lesson_completion, user:, course:)

        expect(user.started_course?(course)).to be(true)
      end
    end

    context 'when the user has not started the course' do
      it 'returns false' do
        expect(user.started_course?(course)).to be(false)
      end
    end
  end

  describe '#on_path?' do
    it 'returns true when the user is on the path' do
      path = create(:path)
      user = create(:user, path:)

      expect(user.on_path?(path)).to be(true)
    end

    it 'returns false when the user is not on the path' do
      path = create(:path)
      user = create(:user)

      expect(user.on_path?(path)).to be(false)
    end
  end

  describe '#ban!' do
    it "hides the user's project submissions" do
      user = create(:user)
      project_submission = create(:project_submission, user:)

      expect { user.ban! }.to change { project_submission.reload.discarded? }.from(false).to(true)
    end

    it 'marks the user as banned' do
      user = create(:user)

      expect { user.ban! }.to change { user.reload.banned? }.from(false).to(true)
    end
  end
end
