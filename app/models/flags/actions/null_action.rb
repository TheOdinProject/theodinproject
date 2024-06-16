class Flags::Actions::NullAction < Flags::Actions::Base
  def perform
    Result.new(success: false, message: 'Failed: Unknown action')
  end
end
