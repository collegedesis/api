class MembershipTypesController < ApplicationController

  def index
    @types = params[:ids] ? MembershipType.where(id: params[:ids]) : MembershipType.all
    render json: @types
  end

  def show
    @type = MembershipType.find(params[:id])
    render json: @type
  end
end