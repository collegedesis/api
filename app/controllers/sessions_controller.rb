class SessionsController < ApplicationController
  def create
    user = User.where(email: params[:session][:email]).first
    if user && user.authenticate_merge_strategy(params[:session][:password])
      puts "SUCCESS: #{user.full_name} was able to authenticate"
      render json: user.session_api_key, status: 201
    else
      puts "FAIL: #{user.full_name} was not able to authenticate"
      render json: {}, status: 401
    end
  end

  def destroy
    session = lookup_session(params[:session])
    session.expire
    render nothing: true, status: 204
  end
end