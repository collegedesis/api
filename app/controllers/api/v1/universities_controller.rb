class Api::V1::UniversitiesController < ApplicationController
  respond_to :json
  def index
    @universities = params[:id] ? University.where(id: params[:ids]) : University.all
    render json: @universities
  end

  def show
    @uni = University.find(params[:id])
    render json: @uni
  end
end
