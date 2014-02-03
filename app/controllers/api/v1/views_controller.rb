class Api::V1::ViewsController < ApplicationController
  def create
    conditions = {
      viewable_id: params[:view][:viewable_id],
      ip: request.remote_ip,
      viewable_type: params[:view][:viewable_type]
    }
    view = View.find(:first, conditions: conditions) || View.create(conditions)
    render json: view
  end
end