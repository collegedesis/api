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
    # Get a user object
    @user = User.find_or_create_by_email(params[:user][:email])
    # save and update params if the user is new
    if @user.new_record?
      params[:user][:memberships_attributes] = [] if !params[:user][:memberships_attributes]
      if !@user.update_attributes(params[:user])
        render json: @user.errors, status: 422
        return
      end
    end
    render json: @user
  end
end