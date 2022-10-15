class AboutPage::BeliefComponent < ApplicationComponent
  with_collection_parameter :belief

  def initialize(belief:)
    @belief = belief
  end
end
