class ProjectSubmissions::FlagsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project_submission

  def new
    @flag = @project_submission.flags.new
  end

  def create
    @flag = @project_submission.flags.new(flag_params)

    respond_to do |format|
      if @flag.save
        notify_discord_admins

        format.html { redirect_to lesson_path(@project_submission.lesson) }
        format.turbo_stream { flash.now[:notice] = 'Thank you! your report has been submitted.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_project_submission
    @project_submission = ProjectSubmission.find(params[:project_submission_id])
  end

  def flag_params
    params.require(:flag).permit(:reason, :extra).merge(flagger: current_user)
  end

  def notify_discord_admins
    return unless discord_notifications_enabled?

    DiscordNotifier.notify(
      Notifications::FlagSubmission.new(@flag)
    )
  end

  def discord_notifications_enabled?
    Rails.env.production? && ENV['STAGING'].blank?
  end
end
