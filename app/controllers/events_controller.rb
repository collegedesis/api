class EventsController < ApplicationController
  respond_to :json

  def index
    @events = params[:id] ? Event.where(ids: [params][:id]) : Event.all 
    render json: @events
  end
  def create
    name = params[:event][:name]
    date = params[:event][:date].to_date
    organization_id = params[:event][:organization_id]
    
    @event = Event.new(name: name, date: date, organization_id: organization_id)
    if @event.save
      render json: @event
    else
      render json: @event.errors
    end
  end
end
