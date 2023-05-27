class Feature
  def self.enabled?(name, actor)
    Flipper.enabled?(name.to_sym, actor)
  end
end
