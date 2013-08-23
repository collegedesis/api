class Api::V1::OrganizationTypesController < ApplicationController
  respond_to :json

  def index
    @org_types = OrganizationType.all
    render json: @org_types
  end

  def show
    @org_type = OrganizationType.find(params[:id])
    render json: @org_type
  end
end