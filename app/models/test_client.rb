class TestClient

  def fetch_listings(airbnb_id, page: 0)
    requested = 10
    current_page = requested * page
    response = Faraday.get "https://www.airbnb.com/api/v2/user_promo_listings?_limit=#{requested}&_offset=#{current_page}&currency=USD&key=d306zoyjsyarp7ifhu67rjxn52tv0t20&locale=en&user_id=#{airbnb_id}"
    ActiveSupport::JSON.decode(response.body)['user_promo_listings']
  end


  def listing_availability(listing_airbnb_id)
    response = Faraday.get "https://www.airbnb.com/api/v3/PdpAvailabilityCalendar?operationName=PdpAvailabilityCalendar&locale=en&currency=USD&variables=%7B%22request%22%3A%7B%22count%22%3A12%2C%22listingId%22%3A%22#{listing_airbnb_id}%22%2C%22month%22%3A2%2C%22year%22%3A2021%7D%7D&extensions=%7B%22persistedQuery%22%3A%7B%22version%22%3A1%2C%22sha256Hash%22%3A%22b94ab2c7e743e30b3d0bc92981a55fff22a05b20bcc9bcc25ca075cc95b42aac%22%7D%7D&_cb=1dif7ru1xwb219&key=d306zoyjsyarp7ifhu67rjxn52tv0t20"

    ActiveSupport::JSON.decode(response.body)['data']['merlin']['pdpAvailabilityCalendar']['calendarMonths']

  end


end