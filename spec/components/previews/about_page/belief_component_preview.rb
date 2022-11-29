module AboutPage
  # @label Media Cards
  # Note: Name is no longer really representative of what this does, should be refactored to a more general name
  class BeliefComponentPreview < ViewComponent::Preview
    def with_about_page_collection
      render(BeliefComponent.with_collection(I18n.t('static_pages.about.beliefs')))
    end

    def with_contributing_page_collection
      render(BeliefComponent.with_collection(I18n.t('static_pages.contributing.benefits')))
    end
  end
end
