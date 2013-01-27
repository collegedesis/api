class UsersController < ApplicationController
  respond_to :json
  def index
    @users = params[:id] ? User.where(id: params[:id]) : User.all
    render json: @users
  end
  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    @user = User.find_or_create_by_email(params[:user])
    render json: @user
  end
end