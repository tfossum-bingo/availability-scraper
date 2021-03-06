class Host < ApplicationRecord
  has_many :listings, dependent: :destroy

  after_create :initial_scrape


  def refresh_host
    scraping_agent = ScrapingClient.new
    #TODO I'd like to wrap to throw this to a queue and wrap their processing in a transaction
    self.update(last_scraped: Time.now)
    delete_listings
    host_listings(scraping_agent).each do |airbnb_listing|
      available_months = scraping_agent.listing_availability(airbnb_listing['id'])
      if available_months.any?
        airbnb_listing = Listing.create(host_id: self.id,
                                        airbnb_id: airbnb_listing['id'],
                                        last_scraped: Time.now)
        process_availabilities(available_months, airbnb_listing)
      end
    end
  end

  private

  def host_listings(scraping_agent)
    all_listings = []
    counter = 0
    loop do
      listing_batch = scraping_agent.fetch_listings(self.airbnb_id, page: counter)
      all_listings += listing_batch
      break if listing_batch.length < 10 or all_listings.length >= 20
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
          return true if counter >= 60
        end
      end

    end
  end

  def delete_listings
    listings.map { |listing| listing.destroy } unless listings.nil?
  end


  def initial_scrape
    ScrapeHostJob.perform_later(self)
  end

end
