class CommentsController < ApplicationController
  before_filter :authenticate_user!, :only => [:create]

  def index
    @comments = params[:ids] ? Comment.where(id: params[:ids]) : Comment.all
    render json: @comments
  end

  def create
    @commentable = Bulletin.find(params[:comment][:bulletin_id])
    if @commentable
      @comment = @commentable.comments.create(
        body: params[:comment][:body],
        user_id: current_user.id
      )
      render json: @comment
    else
      render json: {errors: 'Bulletin not found'}, status: 404
    end
  end

  def authenticate_user!
    current_user
  end
end
