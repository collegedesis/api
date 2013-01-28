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
    _user = User.find_or_create_by_email(params[:user][:email])
    # Authenticate the user with the password they sent.
    @user = User.authenticate(_user.email, params[:user][:password])
    # Set the user's id in the session variable
    if @user
      session[:user_id] = @user.id
      render json: @user
    else
      render json: { errors: ['Authentication failed'] }, status: 401
    end
  end
end