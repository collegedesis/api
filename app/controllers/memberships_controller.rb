class MembershipsController < ApplicationController
  respond_to :json

  def index
    @mems = if params[:ids]
      Membership.where(id: params[:ids])
    else
      Membership.all
    end
    @mems = @mems.select {|m| m if m.approved? }
    render json: @mems
  end

  def show
    @mem = Membership.find(params[:id])
    render json: @mem
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