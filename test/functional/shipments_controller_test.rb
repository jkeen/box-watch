require 'test_helper'

class ShipmentsControllerTest < ActionController::TestCase
  test "shipment can be created" do
    post :create, { :shipment => { :tracking_number => "1Z5R89390262095290" } }

    assert_response :success
  end

  test "shipment can be shown" do
    get :show, { :tracking_number => "1Z5R89390262095290" }
    assert_response :success
  end


end
