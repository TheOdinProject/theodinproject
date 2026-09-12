class NewTabTextLinkComponent < ApplicationComponent
  option :text, reader: :private
  option :href, reader: :private
  option :classes, reader: :private
  option :data, default: -> {}, reader: :private
  option :noreferrer, default: -> { true }, reader: :private
end
