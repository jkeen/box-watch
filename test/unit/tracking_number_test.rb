require 'test_helper'

class TrackingNumberTest < ActiveSupport::TestCase
  test "valid ups number returns ups" do
    assert_equal :ups, TrackingNumber.new("1Z5R89390357567127").carrier
    assert_equal :ups, TrackingNumber.new("1Z879E930346834440").carrier 
    assert_equal :ups, TrackingNumber.new("1Z410E7W0392751591").carrier 
    assert_equal :ups, TrackingNumber.new("1Z8V92A70367203024").carrier 
  end
  
  test "valid fedex number returns fedex" do
    # Fedex Express
    assert_equal :fedex, TrackingNumber.new("986578788855").carrier
    assert_equal :fedex, TrackingNumber.new("477179081230").carrier 
    
    #Fedex Ground (96)
    assert_equal :fedex, TrackingNumber.new("9611020987654312345672").carrier 

    #Fedex Ground (SSCC18)
    assert_equal :fedex, TrackingNumber.new("000123450000000027").carrier 
  end
  
  test "valid dhl number returns dhl" do
    assert_equal :dhl, TrackingNumber.new("73891051146").carrier
  end
  
  test "valid usps number returns usps" do
    assert_equal :usps, TrackingNumber.new("9101 1234 5678 9000 0000 13").carrier
  end
  
  test "invalid number returns unknown" do
    assert_equal :unknown, TrackingNumber.new("9101").carrier
    assert_equal false, TrackingNumber.new("9101").valid?
  end
end
