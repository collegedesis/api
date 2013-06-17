class OrganizationsController < ApplicationController
  respond_to :json
  def index
    if params[:slug]
      @organizations = Organization.where(slug: params[:slug])
    else
      @organizations = Organization.filter_by_params(params)
    end
    render json: @organizations
  end

  def show
    @organization = Organization.where(id: params[:id]).first
    render json: @organization
  end

  def create
    @org = Organization.new(params[:organization])
    if @org.save
      render json: @org
    else
      render json: @org.errors
    end
  end

  def update
    @org = Organization.find(params[:id])
    if @org.update_attributes(params[:organization])
      render json: @org
    else
      render json: {errors: @org.errors}
    end
  end

  def apply
    org = Organization.find_by_id(params[:id])
    email1 = AdminMailer.application_notify(params[:application], current_user.email, current_user.full_name).deliver
    email2 = AdminMailer.application_notify(params[:application], org.email, current_user.full_name).deliver
    render nothing: true, status: 204
  end

  def verify
    @org = Organization.find(params[:id])
    code = rand(1000).to_s
    if VerificationMailer.verify_organization(@org, code).deliver
      encrypted_code = Digest::MD5.hexdigest(code)
      render json: {org: @org, code: encrypted_code}
    else
      render json: {org: @org, code: nil}
    end
  end
end