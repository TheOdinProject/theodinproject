class SitemapController < ApplicationController
  def index
    @static_pages = static_pages
    @courses = Course.all

    respond_to do |format|
      format.xml
    end
  end

  private

  def static_pages
    [root_url, about_url, faq_url, sign_in_url, sign_up_url].freeze
  end
end
