class Event < ActiveRecord::Base
  after_create :send_confirmation_email
  belongs_to :organization

  def send_confirmation_email
    if self.organization.has_email?
      OrganizationMailer.confirm_event_create(self).deliver
    end
  end
end
