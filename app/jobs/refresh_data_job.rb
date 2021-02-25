class RefreshDataJob < ApplicationJob
  queue_as :default

  after_perform do |job|
    delay_minutes =
    if Rails.env.production?
      240
    else
      10
    end
    self.class.set(:wait => delay_minutes.minutes).perform_later
  end

  def perform(*args)
    Scraper.new.refresh_hosts
  end
end
