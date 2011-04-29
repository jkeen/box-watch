class Admin::OverviewController < ApplicationController
  before_filter :authenticate
  helper :shipments
  
  def index
    @mails = IncomingMail.all(:include => [:shipments])
  end
  
  def show
    @mail = IncomingMail.find(params[:id])
  end
  
  protected
  
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == AdminSettings.username && password == AdminSettings.password
    end
  end
end
