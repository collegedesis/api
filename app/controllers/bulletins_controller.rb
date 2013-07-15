class BulletinsController < ApplicationController
  respond_to :json
  before_filter :authenticate_user!, :only => [:create]

  def index
    ## TODO dead bulletins shouldn't show up when routing directly by slug.
    if params[:slug]
      @bulletins = Bulletin.where(slug: params[:slug])
    elsif params[:page]
      page = params[:page].to_i - 1
      @bulletins = Bulletin.homepage
    end
    render json: @bulletins
  end

  def show
    @bulletin = Bulletin.find_by_slug(params[:id]) || Bulletin.first
    render json: @bulletin
  end

  def create
    # to avoid duplicate links
    if params[:bulletin][:bulletin_type] == 2
      @bulletin = Bulletin.find_or_initialize_by_url(params[:bulletin][:url])
    else
      @bulletin = Bulletin.new
    end

    # add in param attributes unless it's an existing bulletin
    if @bulletin.new_record?
      @bulletin.title         = params[:bulletin][:title]
      @bulletin.body          = params[:bulletin][:body]
      @bulletin.bulletin_type = params[:bulletin][:bulletin_type]
      @bulletin.user_id       = current_user.id

      # assign author
      # if author_type is User, verify that the id is the same as the current user's id
      if params[:bulletin][:author_type] == 'User'
        if params[:bulletin][:author_id] == current_user.id
          @bulletin.author_id = current_user.id
          @bulletin.author_type = params[:bulletin][:author_type]
        end
      # else if the author_type is an Organization
      # make sure the current user is a member of that organization
      # and then assign that organization as the author
      elsif params[:bulletin][:author_type] == 'Organization'
        organization = Organization.find(params[:bulletin][:author_id])
        if organization && current_user.is_member_of?(organization)
          @bulletin.author_id = organization.id
          @bulletin.author_type = 'Organization'
        end
      end

      # save
      @bulletin.save
    end

    # current_user votes on it
    @bulletin.votes.create(user_id: current_user.id) if !@bulletin.voted_by_user?(current_user)

    session[:votedBulletinIds] = [] if !session[:votedBulletinIds]
    session[:votedBulletinIds].push(@bulletin.id) if !session[:votedBulletinIds].include? @bulletin.id

    render json: @bulletin
  end

  def authenticate_user!
    current_user
  end
end