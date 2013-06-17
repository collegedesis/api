class ApplicationController < ActionController::Base
  protect_from_forgery
  after_filter :set_access_control_headers

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end
end
