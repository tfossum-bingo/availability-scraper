class ScrapeHostJob < ApplicationJob
  queue_as :urgent

  def perform(host)
    scraper = Scraper.new
    scraper.refresh_host(host)
  end
end
