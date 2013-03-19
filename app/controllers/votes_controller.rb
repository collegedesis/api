class VotesController < ApplicationController
  
  def index
    @votes = params[:id] ? Vote.find(params[:id]) : Vote.all
    render json: @votes
  end

  def create
    # find the thing we're voting on
    # this needs to be changed when we want to vote on things that are not bulletins
    @votable = Bulletin.find(params[:vote][:bulletin_id]) if params[:vote][:bulletin_id]

    # we want to a find a vote on this bulletin that was subitted by this IP
    # checking for a votable is some insurance. We'll do some client side validations too
    if @votable
      @vote = @votable.votes.find_by_submitted_by_ip(request.remote_ip)
      # if there's a user signed in
      if current_user

        # if we have a vote and the vote has a user and it's not the current user
        # we'll create a new vote and assign the current user to it
        if @vote && @vote.user && @vote.user != current_user
          @vote = @votable.votes.create(params[:vote])
          @vote.update_attributes(user: current_user)
        end

        # if we have a vote, and the vote has a user and it's the current_user
        # we won't do anything
        if @vote && @vote.user && @vote.user == current_user
          # don't do anything
        end

        # if we have a vote and it doesn't have a user
        # we'll assign the current user
        if @vote && !@vote.user
          @vote.update_attributes(user: current_user)
        end

        # if we don't have a vote, we'll find or create it by the current user
        if !@vote
          @vote = @votable.votes.find_or_create_by_user_id(current_user.id)
          @vote.update_attributes(submitted_by_ip: request.remote_ip)
        end
      end

      # if we don't have a vote and no one is signed in
      # we'll create a new vote and assign the IP to it
      if !@vote && !current_user
        @vote = @votable.votes.create
        @vote.update_attributes(submitted_by_ip: request.remote_ip)
      end

      # we'll tell the session about this vote
      session[:votedBulletinIds] = [] if !session[:votedBulletinIds]
      session[:votedBulletinIds].push(@votable.id) if !session[:votedBulletinIds].include? @votable.id

      # render the vote back to ember
      render json: @vote
    end
  end
end
