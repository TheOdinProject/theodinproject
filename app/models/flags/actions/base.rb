class Flags::Actions::Base
  def initialize(admin_user:, flag:)
    @admin_user = admin_user
    @flag = flag
  end

  def self.perform(**)
    new(**).perform
  end

  def perform
    raise NotImplementedError
  end

  private

  attr_reader :admin_user, :flag

  class Result
    attr_reader :message

    def initialize(success: false, message: '')
      @success = success
      @message = message
    end

    def success?
      @success
    end
  end
end
