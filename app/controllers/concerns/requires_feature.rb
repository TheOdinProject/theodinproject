module RequiresFeature
  def requires_feature(name, **)
    before_action(
      lambda do
        return if Flipper.enabled?(name, current_user)

        redirect_to dashboard_path, notice: 'Feature not enabled'
      end,
      **
    )
  end
end
