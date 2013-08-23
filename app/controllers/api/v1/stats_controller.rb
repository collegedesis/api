class Api::V1::StatsController < ApplicationController
  def info
    orgs = Organization.count
    unis = University.count
    states = University.all.map(&:state).uniq.count
    render json: {
      orgsCount: orgs,
      universityCount: unis,
      stateCount: states,
    }
  end
end