class Location < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :events
  scope :shipment_events, lambda { |shipment_id| where("shipment_id = ?", shipment_id) }

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode

  def address
    "#{city}, #{state} #{postal_code} #{country}"
  end
end
