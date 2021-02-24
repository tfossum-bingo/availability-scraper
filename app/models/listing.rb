class Listing < ApplicationRecord
  belongs_to :host
  has_many :availabilities, dependent: :destroy

  def booked_days
    booked_array = []
    temp_booked = availabilities.select{|a| a.available == false}
    if temp_booked.any?
      temp_booked.each_with_index do |day, index|
        booked_array << {title: "Event ${index}",
                         start: day.availability_date,
                         end: day.availability_date + 1.day,
                         repeat: 'never',
                         categoryId: 2}
      end
    end
    booked_array
  end
end
