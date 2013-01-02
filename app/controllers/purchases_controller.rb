class PurchasesController < ApplicationController
  respond_to :json, only: [:create]
  after_filter :expire_purchase, only: [:show]
  def create
    token = params[:purchase][:stripe_card_token]
    product = Product.find params[:purchase][:product_id]

    begin 
      Stripe::Charge.create(
        amount: (product.price) * 100,
        currency: 'usd',
        card: token,
        description: params[:purchase][:email]
      )
      @purchase = Purchase.new(
        product_id: product.id,
        beneficiary_id: params[:purchase][:beneficiary_id].to_i,
        download_code: download_code,
        email: params[:purchase][:email]
      )
    if @purchase.save
      response_data = @purchase.download_url(request.host, request.port)
    else
      response_data = @purchase.errors
    end
    render json: {response: response_data}
    rescue Stripe::CardError
      response_data = "Your card was declined"
      render json: {response: response_data}
      return
    end
  end

  def show
    @purchase = Purchase.where(download_code: params[:download_code]).first
    @download_url = @purchase.s3_timed_url if @purchase && @purchase.is_valid?
  end


  def download_code
    chars =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
    code  =  (0...50).map{ chars[rand(chars.length)] }.join
  end
  private
  def require_login
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      md5_of_password = Digest::MD5.hexdigest(password)
      username == "desi" && md5_of_password == 'be121740bf988b2225a313fa1f107ca1'
    end
  end 

  def expire_purchase
    @purchase = Purchase.where(download_code: params[:download_code]).first 
    @purchase.update_attributes(expired: true) if @purchase
  end
end