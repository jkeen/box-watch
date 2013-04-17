class Location < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :events
  scope :shipment_events, lambda { |shipment_id| where("shipment_id = ?", shipment_id) }

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode

  def address
    "#{city.try(:titleize)}, #{state.try(:upcase)}, #{postal_code} #{country}"
  end

  def address=(address)
    puts address
  end


  def as_json(options = {})
    super({:method => :address})
  end
end
