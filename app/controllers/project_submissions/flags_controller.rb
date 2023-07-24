class ProjectSubmissions::FlagsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project_submission

  def new
    @flag = @project_submission.flags.new
  end

  def create # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    @flag = @project_submission.flags.new(flag_params)

    respond_to do |format|
      if @flag.save
        notify_discord_admins

        format.html { redirect_to lesson_path(@project_submission.lesson) }
        format.json { render json: @flag, status: :created }
        format.turbo_stream { flash.now[:notice] = 'Thank you! your report has been submitted.' }
      else
        format.json { render json: { error: 'Unable to flag project submission' }, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_project_submission
    @project_submission = ProjectSubmission.find(params[:project_submission_id])
  end

  def flag_params
    if Feature.enabled?(:v2_project_submissions, current_user)
      params.require(:flag).permit(:reason).merge(flagger: current_user)
    else
      params.permit(:reason).merge(flagger: current_user)
    end
  end

  def notify_discord_admins
    return unless Rails.env.production?

    DiscordNotifier.notify(
      Notifications::FlagSubmission.new(@flag)
    )
  end
end
