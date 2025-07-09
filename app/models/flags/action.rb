Flags::Action = Data.define(:value, :name, :description, :past_tense) do
  include Enumerable

  def self.all
    I18n.t('flag_actions').map { |action| new(**action) }
  end

  def self.each(&)
    all.each(&)
  end

  def self.for(value)
    all.find { |action| action.value == value }
  end
end
