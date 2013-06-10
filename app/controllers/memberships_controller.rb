class MembershipsController < ApplicationController
  respond_to :json

  def index
    @mems = if params[:id]
      Membership.where(id: params[:id])
    else
      Membership.all
    end
    @mems.select! {|m| m.approved? }
    render json: @mems
  end

  def show
    @mem = Membership.find(params[:id])
    render @mem
  end

  def create
    conditions = params[:membership]
    @membership = Membership.find(:first, conditions: conditions) || Membership.new(conditions)
    render json: @membership.save ? @membership : @membership.errors
  end

  def destroy
    @membership = Membership.find(params[:id])
    @membership.delete
    render nothing: true, status: 204
  end
end