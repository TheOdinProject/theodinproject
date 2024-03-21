module Media
  # @label Media Cards
  class MediaCardComponentPreview < ViewComponent::Preview
    def with_about_page_collection
      render(MediaCardComponent.with_collection(I18n.t('static_pages.about.beliefs')))
    end

    def with_contributing_page_collection
      render(MediaCardComponent.with_collection(I18n.t('static_pages.contributing.benefits')))
    end
  end
end
