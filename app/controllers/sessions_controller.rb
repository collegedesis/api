class SessionsController < ApplicationController
  before_action :log_this, only: [:create]

  def create
    user = User.where(email: params[:session][:email]).first
    if user && user.authenticate_merge_strategy(params[:session][:password])
      puts "SUCCESS: #{user.full_name} was able to authenticate"
      render json: user.session_api_key, status: 201
    else
      if user
        msg = "Error: Wrong password for #{user.email}."
      else
        msg = "Error: Could not find account with email: #{params[:session][:email]}."
      end
      puts msg
      render json: msg, status: 401
    end
  end

  def destroy
    session = lookup_session(params[:session])
    session.expire
    render nothing: true, status: 204
  end

  private

  def log_this
   puts "I'm in the sessions controller before create action"
  end
end
