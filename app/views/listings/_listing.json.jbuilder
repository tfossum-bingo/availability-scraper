json.extract! listing, :id, :host_id, :airbnb_id, :address1, :address2, :city, :state, :postal_code, :active, :last_scraped, :created_at, :updated_at
json.url listing_url(listing, format: :json)
