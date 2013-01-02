class Purchase < ActiveRecord::Base
  attr_accessible :beneficiary_id, :product_id, :email, :expired, :download_code, :stripe_card_token
  attr_accessor :stripe_card_token
  
  belongs_to :product
  belongs_to :beneficiary, class_name: Organization

  validates_numericality_of :product_id, :beneficiary_id
  validates_presence_of :product_id
  
  after_create :send_notification_emails

  def s3_timed_url
    url = AWS::S3::S3Object.url_for(s3_filename, DEFAULT_BUCKET)
  end

  def download_url(host, port)
    code = self.download_code
    if port
      domain = "#{host}:#{port}"
    else
      domain = "#{host}"
    end
    "/purchases/#{id}?download_code=#{code}"
  end
  
  def is_valid?
    !expired
  end  

  def s3_obj
    obj = AWS::S3::S3Object.find(s3_filename, DEFAULT_BUCKET)
    obj.url(expires_in: 30)
    return obj
  end

  def s3_filename
    product.name + ".zip"
  end

  private
  def send_notification_emails
    if self.beneficiary_id?
      OrganizationMailer.earnings_notification(self.beneficiary, self.product).deliver
    end
    MemberMailer.purchase_receipt(self).deliver if self.email?
  end
end