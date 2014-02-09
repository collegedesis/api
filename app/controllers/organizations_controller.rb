class OrganizationsController < ApplicationController

  def index
    if params[:slug]
      @organizations = Organization.where(slug: params[:slug])
      render json: @organizations
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

  def search
    states = (params[:states] || "").split(',')
    param = params[:query]
    @organizations = Organization.filter_and_search_by_query(states, param)
    render json: @organizations, each_serializer: BasicOrganizationSerializer
  end
end
