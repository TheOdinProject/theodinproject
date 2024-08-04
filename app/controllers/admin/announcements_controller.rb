module Admin
  class AnnouncementsController < Admin::BaseController
    def index
      @pagy, @announcements = pagy(Announcement
        .for_status(params.fetch(:status, :active))
        .ordered_by_recent, items: 20)
    end

    def show
      @announcement = Announcement.find(params[:id])
    end

    def new
      @announcement = Announcement.new
    end

    def edit
      @announcement = Announcement.find(params[:id])
    end

    def create
      @announcement = Announcement.new(announcement_params.merge(admin_user: current_admin_user))

      if @announcement.save
        create_activity(@announcement, 'created')
        redirect_to admin_announcement_path(@announcement)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @announcement = Announcement.find(params[:id])

      if @announcement.update(announcement_params)
        create_activity(@announcement, 'updated')
        redirect_to admin_announcement_path(@announcement), notice: 'Announcement updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @announcement = Announcement.find(params[:id])

      @announcement.destroy

      redirect_to admin_announcements_path, notice: 'Announcement deleted.'
    end

    private

    def announcement_params
      params.require(:announcement).permit(:message, :expires_at, :learn_more_url)
    end

    def create_activity(announcement, key)
      announcement.create_activity(
        key: "announcement.#{key}",
        owner: current_admin_user,
        parameters: { params: announcement_params.to_h }
      )
    end
  end
end
