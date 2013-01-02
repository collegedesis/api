class SiteController < ApplicationController
  # before_filter :require_login, only: [:blog]
  def blog
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  end

  def home    
  end
  
  private
  def require_login
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      md5_of_password = Digest::MD5.hexdigest(password)
      username == "desi" && md5_of_password == 'be121740bf988b2225a313fa1f107ca1'
    end
  end
end
