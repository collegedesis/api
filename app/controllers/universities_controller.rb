class UniversitiesController < ApplicationController
  def index
    @universities = params[:id] ? University.where(id: params[:ids]) : University.all
    render json: @universities
  end

  def show
    @uni = University.find(params[:id])
    render json: @uni
  end
end
