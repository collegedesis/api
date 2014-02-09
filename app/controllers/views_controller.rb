class ViewsController < ApplicationController
  def create
    view = View.find_or_create_by(
      viewable_id: params[:view][:viewable_id],
      ip: request.remote_ip,
      viewable_type: params[:view][:viewable_type]
    )
    render json: view
  end
end