module AdminV2
  class FlagsController < AdminV2::BaseController
    def index
      @pagy, @flags = pagy(Flag.by_status(params.fetch(:status, 'active')), items: 20)
    end
  end
end
