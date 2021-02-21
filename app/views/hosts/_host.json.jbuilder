json.extract! host, :id, :host_name, :airbnb_id, :active, :last_scrapped, :created_at, :updated_at
json.url host_url(host, format: :json)
