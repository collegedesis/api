class SessionsController < ApplicationController

  def create
    begin
      puts "----------#{params[:email]}logging in!---------"
      puts params[:email]
      puts "-----------logging in---------"
    end

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

  def destroy
    session[:user_id] = nil
    render nothing: true, status: 204
  end
end