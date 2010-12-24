class ShipmentsController < ApplicationController
  before_filter :find_shipment
  
  def show  
  end
  
  private
  
  def find_shipment
    @shipment = if params[:id]
      Shipment.find(params[:id])      
    elsif params[:tracking_number]
      Shipment.find_by_tracking_number(params[:tracking_number])
    end
  end
end
