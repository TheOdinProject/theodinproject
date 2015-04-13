class CurriculumController < ApplicationController

  def index
    # URLs for the github API take the direct path form
    # and not the explicit URL-at-the-browser-bar form...
    # https://api.github.com/repos/theodinproject
    #   /curriculum/contents/contributing.md

    begin

      # Decode the gibberish into a real file and render to html
      decoded_file = Base64.decode64(gh_file["content"])
      @file = md(decoded_file)

    # serve all errors as 404: Not Found
    # NOTE: API rate limit errors will still look like 404's now
    rescue
      raise ActionController::RoutingError.new('Not Found')
    end

    render :index # defaults to use the layouts/curriculum template

  end

  private

  # Search a directory response object from Github for an index
  # Prefer to serve .html files over .md
  def get_index_from_dir(api_object, response_dir)
    response_dir.body.each do |item|
      if item.name =~ /index\.(html|md)/
        return get_contents(api_object, item.path)
      end
    end
    nil
  end

  def github
    @github ||= Github::Repos.new(:user => "theodinproject", :repo => "curriculum", :oauth_token => "#{ENV['GITHUB_API_TOKEN']}")
  end

  def get_contents(api_object, path)
    api_object.contents.get :path => path
  end

  def gh_file
    # If we've been returned a directory instead of a file
    # (e.g. for /ruby as opposed to /ruby/index.md)
    # Search through it looking for an index file
    # if we find one, grab that file and proceed normally

    dir = params[:dir] || "index.md"
    response = get_contents(github, "#{dir}")

    return response unless response.body.is_a?(Array)
    get_index_from_dir(github, response)
  end
end
