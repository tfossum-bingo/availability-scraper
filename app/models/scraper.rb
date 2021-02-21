class Scraper

  attr_accessor :scraping_agent

  def initialize
    super
    @scraping_agent = TestClient.new
  end

  def refresh_data
    #Taking brute force approach of wiping all data and then refreshing
    hosts = Host.includes(:listings).all.order(airbnb_id: :asc)
    hosts.map { |host| refresh_host(host) }
  end

  def refresh_host(host)
    #TODO I'd like to wrap to throw this to a queue and wrap their processing in a transaction
    host.update(last_scraped: Time.now)
    delete_listings(host)
    airbnb_listings = host_listings(host.airbnb_id)
    airbnb_listings.each do |airbnb_listing|
      available_months = @scraping_agent.listing_availability(airbnb_listing['id'])
      if available_months.any?
        airbnb_listing = Listing.create(host_id: host.id,
                                        airbnb_id: airbnb_listing['id'],
                                        last_scraped: Time.now)
        process_availabilities(available_months, airbnb_listing)
      end
    end
  end

  def host_listings(host_airbnb_id)
    all_listings = []
    counter = 0
    loop do
      listing_batch = scraping_agent.fetch_listings(host_airbnb_id, page: counter)
      all_listings += listing_batch
      break if listing_batch.length < 10 or counter > 10
      counter += 1
    end
    all_listings
  end

  def process_availabilities(availability_months, listing)
    counter = 0
    availability_months.each do |availability_month|
      current_avails = availability_month['days']
      current_avails.try(:each) do |a|
        avail_data = a['calendarDate'].to_date
        if avail_data >= Date.today
          counter += 1
          Availability.create(listing_id: listing.id,
                              availability_date: a['calendarDate'].to_date,
                              available: a['available'])
          return true if counter >= 90
        end
      end

    end
  end

  def delete_listings(host)
    host.listings.map { |listing| listing.destroy } unless host.listings.nil?
  end

end