class BulletinsController < ApplicationController
  respond_to :json
  before_filter :authenticate_user!, :only => [:create]

  def index
    @bulletins = params[:title] ? Bulletin.find_by_title(params[:title]) : Bulletin.homepage
    render json: @bulletins
  end

  def show
    @bulletin = Bulletin.find_by_slug(params[:id]) || Bulletin.first
    render json: @bulletin
  end

  def create
    @bulletin = Bulletin.create(params[:bulletin])
    @bulletin.update_attributes(user_id: current_user.id)

    # vote on it
    @bulletin.votes.create(user_id: current_user.id)

    session[:votedBulletinIds] = [] if !session[:votedBulletinIds]
    session[:votedBulletinIds].push(@bulletin.id) if !session[:votedBulletinIds].include? @bulletin.id

    render json: @bulletin
  end

  def authenticate_user!
    current_user
  end
end