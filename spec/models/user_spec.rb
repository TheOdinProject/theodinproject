# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string(255)
#  learning_goal          :text
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  admin                  :boolean          default(FALSE), not null
#  avatar                 :string
#  path_id                :integer          default(1)
#  banned                 :boolean          default(FALSE), not null
#
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
  it { is_expected.to belong_to(:path).optional(true) }

  context 'when user is created' do
    let!(:default_path) { create(:path, default_path: true) }

    it 'enrolls the user in the default path' do
      user = create(:user)
      expect(user.path).to eql(default_path)
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
      non_dismissed_flag = create(:flag, flagger: user, taken_action: :ban)
      dismissed_flag = create(:flag, flagger: user, taken_action: :dismiss)

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
end
