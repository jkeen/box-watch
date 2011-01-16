require 'test_helper'

class ShipmentTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "shipment name takes incoming mail subject if not set" do
    shipment = Factory(:shipment)
    assert_equal shipment.name, shipment.incoming_mail.subject
  end
  
  test "shipment name does not take incoming mail subject if set" do
    shipment = Factory(:shipment, :name => "Moo")
    assert_equal "Moo", shipment.name
  end
end
