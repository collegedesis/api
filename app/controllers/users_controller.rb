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
    @user = User.find_or_create_by_email(params[:user])
    # Authenticate the user with the password they sent.
    if @user.confirm_password?(params[:user][:password])
    # Set the user's id in the session variable
      session[:user_id] = @user.id
      render json: @user
    else
      render json: { errors: ['Authentication failed'] }, status: 401
    end
  end
end