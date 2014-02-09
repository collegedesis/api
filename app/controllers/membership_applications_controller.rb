class MembershipApplicationsController < ApplicationController
  before_filter :ensure_authenticated_user, only: [:create]

  def show
    @app = MembershipApplication.find(params[:id])
    render json: @app ? @app : nil, status: 404
  end

  def index
    @apps = params[:ids] ? MembershipApplication.where(id: params[:ids]) : MembershipApplication.all
    render json: @apps
  end

  def create

    attrs = params[:membership_application]
    binding.pry
    if current_user
      if attrs[:user_id].to_i == current_user.id
        application = MembershipApplication.find(:first, conditions: attrs) || MembershipApplication.new(attrs)
        render json: application.save ? application : { errors: "failed" }
      end
    end
  end

  def approve
    @app = MembershipApplication.find_by_code(params[:code])
    if @app
      if @app.application_status_id == APP_STATUS_PENDING
        @app.approve
      end
      redirect_to "/application-response/#{@app.id}"
    else
      render text: "<h3>Couldn't find application</h3>Email
                  <a href='mailto:brownkids@collegedesis.com'>brownkids@collegedesis.com</a>
                   for more info!"
    end
  end

  def reject
    @app = MembershipApplication.find_by_code(params[:code])
    if @app
      if @app.application_status_id == APP_STATUS_PENDING
        @app.reject
      end
      redirect_to "/application-response/#{@app.id}"
    else
      render text: "<h3>Couldn't find application</h3>Email
                    <a href='mailto:brownkids@collegedesis.com'>brownkids@collegedesis.com</a>
                     for more info!"
    end
  end
end