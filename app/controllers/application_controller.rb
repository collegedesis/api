class ApplicationController < ActionController::API
  before_filter :set_access_control_headers

  def set_access_control_headers
    headers['Access-Control-Allow-Origin']    = '*'
    headers['Access-Control-Allow-Methods']   = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method']  = '*'
    headers['Access-Control-Allow-Headers']   = 'Origin, X-Requested-With, Content-Type, Accept, X-AUTH-TOKEN, X-API-VERSION, Authorization'
    headers['Access-Control-Max-Age']         = "1728000"
  end

  def cors_preflight_check
    # logger.info ">>> responding to CORS request"
    puts "responding to CORS request"
    render text: '', content_type: 'text/plain'
  end

  protected

  # Renders a 401 status code if the current user is not authorized
  def ensure_authenticated_user
    head :unauthorized unless current_user
  end

  # Returns the active user associated with the access token if available
  def current_user
    session = ApiKey.active.where(access_token: token).first
    if session
      return session.user
    else
      return nil
    end
  end

  # Parses the access token from the header
  def token
    bearer = request.headers["HTTP_AUTHORIZATION"]

    # allows our tests to pass
    bearer ||= request.headers["rack.session"].try(:[], 'Authorization')

    if bearer.present?
      bearer.split.last
    else
      nil
    end
  end
end
