class Listing < ApplicationRecord
  belongs_to :host
  has_many :availabilities, dependent: :destroy
end
