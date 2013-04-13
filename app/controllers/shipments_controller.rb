class ShipmentsController < ApplicationController
  before_filter :find_shipment
  respond_to :json

  def show
    if TrackingNumber.new(params[:tracking_number]).valid?
      @shipment = Shipment.where(:tracking_number => params[:tracking_number]).includes(:events).first_or_create
      respond_with(@shipment)
    else
      respond_with(@shipment, :status => :not_acceptable)
    end
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
