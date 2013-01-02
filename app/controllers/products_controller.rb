class ProductsController < ApplicationController
  def index
    @products = Product.all
    @bosaa = Product.first
    redirect_to @bosaa if @bosaa
  end
  def show
    @product = Product.find(params[:id])
    @purchase = @product.purchases.new
    @organizations = Organization.all
  end

  private
  def require_login
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      md5_of_password = Digest::MD5.hexdigest(password)
      username == "desi" && md5_of_password == 'be121740bf988b2225a313fa1f107ca1'
    end
  end
end