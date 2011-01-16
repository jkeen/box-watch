require 'test_helper'

class IncomingMailTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "mail with one tracking number creates one shipment" do
    mail = Factory.build(:incoming_mail, :body => "1Z5R89390357567127")
    assert_difference "Shipment.count" do
      mail.save
    end
    
    assert_equal 1, mail.shipments.count
    assert_equal "1Z5R89390357567127", mail.shipments.first.tracking_number
  end

  test "mail with multiple tracking numbers creates multiple shipment" do
    mail = Factory.build(:incoming_mail, :body => %Q{
      1Z5R89390357567127
      000123450000000027
      986578788855
    })
    assert_difference "Shipment.count", 3 do
      mail.save
    end
    
    assert_equal 3, mail.shipments.count
  end
end
