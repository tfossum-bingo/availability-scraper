class ScrapeHostJob < ApplicationJob
  queue_as :default

  def perform(host)
    Scraper.new.refresh_host(host)
  end
end
