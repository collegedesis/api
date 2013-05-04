class MembershipsController < ApplicationController
  respond_to :json

  def index
    @mems = params[:id] ? Membership.where(id: params[:id]) : Membership.all
    render json: @mems
  end

  def show
    @mem = Membership.find(params[:id])
    render @mem
  end

  def create
    @membership = Membership.new(params[:membership])
    render json: @membership.save ? @membership : @membership.errors
  end

  def destroy
    @membership = Membership.find(params[:id])
    @membership.delete
    render nothing: true, status: 204
  end
end