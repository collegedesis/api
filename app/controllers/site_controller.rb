class SiteController < ApplicationController
  before_filter :require_login, only: [:blog]

  def blog
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  end

  def home    
  end
  
  private
  def require_login
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      md5_of_password = Digest::MD5.hexdigest(password)
      username == "desi" && md5_of_password == 'b2bc70904b79e2c58089f88df5670b1b'
    end
  end
end
