class Email < ActiveRecord::Base
  belongs_to :message
  belongs_to :organization
  validates_presence_of :message_id, :organization_id
  after_save :send_email

  private
  def send_email
    CampaignMailer.send_email(self.message, self.organization).deliver
  end
end
