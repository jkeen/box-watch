class Event < ActiveRecord::Base
  belongs_to :item
  default_scope :order => "occurred_at ASC"
end
