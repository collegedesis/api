class VotesController < ApplicationController
  def index
    @votes = params[:id] ? Vote.find(params[:id]) : Vote.all
    render json: @votes
  end

  def create
    # find the thing we're voting on
    # this needs to be changed when we want to vote on things that are not bulletins
    @votable = Bulletin.find(params[:vote][:bulletin_id]) if params[:vote][:bulletin_id]
    if @votable
      @vote = @votable.votes.find_or_create_by_user_id(current_user.id)
      @vote.update_attributes(submitted_by_ip: request.remote_ip)
      # we'll tell the session about the thing we just voted on
      session[:votedBulletinIds] = [] if !session[:votedBulletinIds]
      session[:votedBulletinIds].push(@votable.id) if !session[:votedBulletinIds].include? @votable.id

      # render the vote back to ember
      render json: @vote
    end
  end
end