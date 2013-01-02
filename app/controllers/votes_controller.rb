class VotesController < ApplicationController  

  def create
    if !voted?
      voted_object = create_vote_record(params)
      render json: {vote_count: voted_object.votes.count, voted_letter_id: voted_object.id}
    else
      render json: {message: "You've already voted"}
    end
  end
  
  protected

  def voted?
    if session[:votes]
      session[:votes].include? params[:vote][:votable_id]
    else
      session[:votes] = []
      return false
    end
  end

  def create_vote_record(params)
    votable = find_votable  
    vote = votable.votes.build(params[:vote])
    vote.save!
    session[:votes].push params[:vote][:votable_id]
    return votable
  end

  def find_votable
    votable_type = params[:vote][:votable_type].constantize
    votable = votable_type.find(params[:vote][:votable_id])
  end
end
