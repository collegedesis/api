class BulletinsController < ApplicationController
  respond_to :json
  before_filter :authenticate_user!, :only => [:create]

  def index
    ## TODO dead bulletins shouldn't show up when routing directly by slug.
    @bulletins = params[:slug] ? Bulletin.where(slug: params[:slug]) : Bulletin.homepage
    render json: @bulletins
  end

  def show
    @bulletin = Bulletin.find_by_slug(params[:id]) || Bulletin.first
    render json: @bulletin
  end

  def create
    # to avoid duplicate links
    if params[:bulletin][:bulletin_type] == 2
      @bulletin = Bulletin.find_or_initialize_by_url(params[:bulletin][:url])
    else
      @bulletin = Bulletin.new
    end

    # add in param attributes unless it's an existing bulletin
    if @bulletin.new_record?
      @bulletin.title         = params[:bulletin][:title]
      @bulletin.body          = params[:bulletin][:body]
      @bulletin.bulletin_type = params[:bulletin][:bulletin_type]
      @bulletin.user_id       = current_user.id

      # save
      @bulletin.save
    end

    # current signed in user votes on it
    @bulletin.votes.create(user_id: current_user.id) if !@bulletin.voted_by_user?(current_user)

    session[:votedBulletinIds] = [] if !session[:votedBulletinIds]
    session[:votedBulletinIds].push(@bulletin.id) if !session[:votedBulletinIds].include? @bulletin.id

    render json: @bulletin
  end

  def authenticate_user!
    current_user
  end
end