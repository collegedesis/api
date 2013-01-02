class MemberMailer < ActionMailer::Base
  default from: "brownkids@collegedesis.com"
  def welcome_email(membership)
    @membership = membership
    @member = membership.user
    @org = membership.organization
    mail(to: @member.email, subject: "Thanks for joining #{@org.name}") 
  end

  def purchase_receipt(purchase)
    @product = purchase.product
    @beneficiary = purchase.beneficiary
    @purchase = purchase
    mail(to: purchase.email, subject: "Thank you for purchasing #{@product.name}")
  end
end