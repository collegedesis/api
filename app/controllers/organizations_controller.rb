class OrganizationsController < ApplicationController
  respond_to :json
  def index
    @organizations = params[:id] ? Organization.where(id: params[:id]) : Organization.public
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
    @org.update_attributes(params[:organization])
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