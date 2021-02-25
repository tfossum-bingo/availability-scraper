class Scraper

  attr_accessor :scraping_agent

  def initialize
    super
    @throttle_listings = 20
    @throttle_days = 60

  end

  def refresh_hosts
    #Taking brute force approach of wiping all data and then refreshing
    # Ideally I'd only update what has changed.
    hosts = Host.includes(:listings).all.order(airbnb_id: :asc)
    hosts.map { |host| ScrapeHostJob.perform_later(host) }
  end

end