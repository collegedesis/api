class BulletinFacebookPoster
  attr_accessor :bulletin, :user_graph_api_access_token

  def initialize(bulletin)
    @bulletin = bulletin
    user_graph_api_access_token = USER_GRAPH_ACCESS_TOKEN
    user_graph = Koala::Facebook::API.new(user_graph_api_access_token)
    accounts = page_graph.get_connections("me", "accounts")
    @page_graph_api_access_token = accounts.first["access_token"] # TODO explicitly get the CollegeDesis page
  end

  def self.post_top_bulletin
    bulletin_to_post = Bulletin.homepage.first
    bulletin_to_post.post
  end

  def post
    @page_graph_api_access_token.put_connections("me", 'feed', message: @bulletin.title, link: @bulletin.shortened_url)
  end

end