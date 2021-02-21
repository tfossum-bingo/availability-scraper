class RefreshDataJob < ApplicationJob
  queue_as :default

  after_perform do |job|
    self.class.set(:wait => 10.minutes).perform_later
  end

  def perform(*args)
    Scraper.new.refresh_data
  end
end
