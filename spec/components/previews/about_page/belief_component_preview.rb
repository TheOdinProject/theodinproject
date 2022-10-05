module AboutPage
  class BeliefComponentPreview < ViewComponent::Preview
    def with_about_page_collection
      render(BeliefComponent.with_collection(I18n.t('static_pages.about.beliefs')))
    end

    def with_contributing_page_collection
      render(BeliefComponent.with_collection(I18n.t('static_pages.contributing.benefits')))
    end
  end
end
