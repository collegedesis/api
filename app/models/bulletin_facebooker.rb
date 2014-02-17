class BulletinFacebookPoster
  require 'cgi'
  require 'open-uri'

  attr_accessor :bulletin, :user_graph_api_access_token

  def initialize(bulletin)
    @bulletin = bulletin
    @page = Koala::Facebook::API.new(ENV['FB_PAGE_ACCESS_TOKEN'])
  end

  def self.post_top_bulletin
    bulletin_to_post = Bulletin.where(" created_at > ?", 3.days.ago).first
    bulletin_to_post.post_to_facebook
  end

  def post
    @page.put_connections("me", 'feed', :message => @bulletin.title, :link => @bulletin.shortened_url)
  end
end