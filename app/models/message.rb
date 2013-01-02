class Message < ActiveRecord::Base
  has_many :emails
  has_many :organizations, through: :emails
  validates_presence_of :from_email

  def self.make_message_from_params(params)    
    from_email  = params[:message][:from_email]
    from_name   = params[:message][:from_name]
    subject     = params[:message][:subject]    || "Email from CollegeDesis"
    body        = params[:message][:body]       || "Someone sent out a blank email. That's weird"
    Message.new(from_email: from_email, subject: subject, body: body, from_name: from_name)
  end

  def self.build_recipient_list(string_of_ids)
    str_of_org_ids = string_of_ids
    return str_of_org_ids.split(',')
  end
end