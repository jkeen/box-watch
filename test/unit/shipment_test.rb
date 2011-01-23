require 'test_helper'

class ShipmentTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "shipment name takes incoming mail subject if not set" do
    shipment = Factory(:ups_shipment)
    assert_equal shipment.name, shipment.incoming_mail.subject
  end
  
  test "shipment name does not take incoming mail subject if set" do
    shipment = Factory(:ups_shipment, :name => "Moo")
    assert_equal "Moo", shipment.name
  end
  
  test "creating valid shipment without service set sets service" do
    shipment = Factory.create(:shipment, :tracking_number => "9611020987654312345672")
    assert_equal "fedex", shipment.service
  end
  
  test "creating invalid shipment does not validate" do
    shipment = Factory.build(:shipment, :tracking_number => "9611020987654312345")
    assert !shipment.valid?
  end
end
