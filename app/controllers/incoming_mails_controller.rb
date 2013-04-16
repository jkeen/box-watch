class IncomingMailsController < ApplicationController
  require 'mail'
  skip_before_filter :verify_authenticity_token
  before_filter :verify_signature, :only => :create

  def create
    message = Mail.new(params[:message])

    Rails.logger.info message.subject #print the subject to the logs
    Rails.logger.info message.body.decoded #print the decoded body to the logs

    IncomingMail.create({
      :from => message.from.to_s,
      :to => message.to.to_s,
      :reply_to => message.reply_to.to_s,
      :subject => message.subject.to_s,
      :body => params[:plain],
      :sent_at => message.date})
    # Do some other stuff with the mail message

    render :text => 'success', :status => 200 # a status of 404 would reject the mail
  end

  protected

  def verify_signature
    provided = request.request_parameters.delete(:signature)
    signature = Digest::MD5.hexdigest(request.request_parameters.sort.map{|k,v| v}.join + CloudmailinSettings.secret)

    if provided != signature
      render :text => "Message signature fail #{provided} != #{signature}", :status => 403
      return false
    end
  end
end
