class ShipmentsController < ApplicationController
  respond_to :json, :html

  def show
    if params[:id]
      @shipment = Shipment.find(params[:id])
      respond_with(@shipment)
    elsif params[:tracking_number]
      @shipment = Shipment.where(:tracking_number => params[:tracking_number]).includes(:events).first_or_create
      if @shipment && @shipment.valid?
        respond_with(@shipment)
      else
        respond_with(@shipment, :status => :not_acceptable)
      end
    end
  end

  def new
    @shipment = Shipment.new
  end

  def create
    @shipment = Shipment.new(:tracking_number => params[:tracking_number])

    if @shipment.save
      respond_with(@shipment)
    else
      respond_with(@shipment, :status => :not_acceptable)
    end
  end
end
