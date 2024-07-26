class Github::WebhooksController < ApplicationController
  include GithubWebhook::Processor

  skip_before_action :verify_authenticity_token

  def github_push(payload)
    event = ::Github::PushEvent.new(payload)

    Lessons::UpdateContentJob.perform_later(event.modified_urls) if event.merged_to_main?
  end

  private

  def webhook_secret(_)
    ENV['GITHUB_WEBHOOK_SECRET']
  end
end
