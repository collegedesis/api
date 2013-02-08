class SessionsController < ApplicationController

  def create
    email = params[:email].downcase
    @user = User.where(email: email).first

    if @user.present?
      # If password matches
      if @user.confirm_password?(params[:password])
        session[:user_id] = @user.id
        render json: @user
        return
      end
    end

    render :json => {error: "User not found"}
  end
end