class MessagesController < ApplicationController
  respond_to :json

  def create
    @message       = Message.make_message_from_params(params)
    arr_of_org_ids = Message.build_recipient_list(params[:message][:to_str]) || ""

    if @message.save
      arr_of_org_ids.each {|id| Email.create(message: @message, organization_id: id) }
      render json: @message
    else
      render json: @message.errors
    end
  end

  # Sends test email to the sender. Doesn't create a message object
  # !!! TODO Keep record of Test emails.
  def tests
    subject       = params["messages/test"][:subject]     || "Email from CollegeDesis"
    body          = params["messages/test"][:body]        || "Someone sent out a blank email. That's weird"
    sender_name   = params["messages/test"][:from_name]
    sender_email  = params["messages/test"][:from_email]
    CampaignMailer.send_test(body, subject, sender_name, sender_email).deliver
    render json: 'success'
  end
end