class SiteController < ApplicationController
  # before_filter :require_login, only: [:home]

  def home
    @google_maps_api_key = ENV['GOOGLE_MAPS_API_KEY']
  end

  def info
    orgs = Organization.count
    unis = University.count
    states = University.all.map(&:state).uniq.count
    render json: {
      orgsCount: orgs,
      universityCount: unis,
      stateCount: states,
    }
  end

  private
  def require_login
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      md5_of_password = Digest::MD5.hexdigest(password)
      username == "desi" && md5_of_password == 'b2bc70904b79e2c58089f88df5670b1b'
    end
  end
end
