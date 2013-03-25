class BulletinsController < ApplicationController
  respond_to :json

  before_filter :authenticate_user!, :only => [:create]
  def index
    @bulletins = params[:title] ? Bulletin.find_by_title(params[:title]) : Bulletin.sorted
    render json: @bulletins
  end

  def show
    @bulletin = Bulletin.find(params[:id])
    render json: @bulletin
  end

  def create
    @bulletin = Bulletin.create(params[:bulletin])
    render json: @bulletin
  end

  def authenticate_user!
    current_user
  end
end