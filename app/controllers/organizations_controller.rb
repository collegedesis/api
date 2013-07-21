class OrganizationsController < ApplicationController
  respond_to :json

  def index
    if params[:slug]
      @organizations = Organization.where(slug: params[:slug])
      render json: @organizations
    elsif params[:states]
      @organizations = Organization.filter_by_states(params[:states])
      render json: @organizations, each_serializer: BasicOrganizationSerializer
    else
      @organizations = Organization.filter_by_params(params)
      render json: @organizations, each_serializer: BasicOrganizationSerializer
    end
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
    if current_user && current_user.is_admin_of?(@org)
      if @org.update_attributes(params[:organization])
        render json: @org
      else
        render json: {errors: @org.errors}
      end
    else
      render json: {errors: "Unauthorized" }, status: 401
    end
  end
end
