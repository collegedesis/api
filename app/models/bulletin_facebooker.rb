class BulletinFacebookPoster
  require 'cgi'
  attr_accessor :bulletin, :user_graph_api_access_token

  def initialize(bulletin)
    @bulletin = bulletin
    user_graph_api_access_token = get_access_token
    user_graph = Koala::Facebook::API.new(user_graph_api_access_token)
    accounts = user_graph.get_connections("me", "accounts")
    page_graph_api_access_token = accounts.first["access_token"] # TODO explicitly get the CollegeDesis page
    @page = Koala::Facebook::API.new(page_graph_api_access_token)
  end

  def self.post_top_bulletin
    bulletin_to_post = Bulletin.homepage.first
    bulletin_to_post.post_to_facebook
  end

  def post
    @page.put_connections("me", 'feed', :message => @bulletin.title, :link => @bulletin.shortened_url)
  end

  def get_access_token
    open_graph_url = 'https://graph.facebook.com/oauth/access_token?'

    params = {
      client_id: ENV['FB_CLIENT_ID'],
      client_secret: ENV['FB_CLIENT_SECRET'],
      redirect_uri: CGI.escape("https://collegedesis.com"),
      grant_type: "client_credentials",
    }
    param_string = params.map {|k,v| "#{k}=#{v}"}.join('&')

    request_url = open_graph_url + param_string
    response = open(request_url)
    return response.read.split('=').last
  end
end