class BulletinsController < ApplicationController
  respond_to :json
  def index
    @bulletins = Bulletin.all
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
end
