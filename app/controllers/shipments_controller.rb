class ShipmentsController < ApplicationController
  before_filter :find_shipment

  def show
  end
  
  def new
    @shipment = Shipment.new
  end
  
  def create
    @shipment = Shipment.new(:tracking_number => params[:shipment][:tracking_number])
    
    if @shipment.save
      redirect_to @shipment
    else
      render :action => "new"
    end
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
