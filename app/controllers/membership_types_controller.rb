class MembershipTypesController < ApplicationController
  respond_to :json

  def index
    @types = params[:ids] ? MembershipType.where(id: params[:ids]) : MembershipType.all
    binding.pry
    render json: @types
  end

  def show
    @type = MembershipType.find(params[:id])
    render json: @type
  end
end