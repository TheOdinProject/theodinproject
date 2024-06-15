class Flags::Actions::NullAction < Flags::Actions::Action
  def perform
    Result.new(success: false, message: 'Failed: Unknown action')
  end
end
