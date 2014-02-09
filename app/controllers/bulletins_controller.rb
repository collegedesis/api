class BulletinsController < ApplicationController
  before_filter :ensure_authenticated_user, only: [:create]

  def index
    if params[:slug]
      @bulletins = Bulletin.where(slug: params[:slug])
    elsif params[:ids]
      @bulletins = Bulletin.where(id: [params[:ids]])
    else
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
    @bulletin = Bulletin.find_or_initialize_by(url: params[:bulletin][:url])
    # add in param attributes unless it's an existing bulletin
    if @bulletin.new_record?
      @bulletin.title         = params[:bulletin][:title]
      @bulletin.body          = params[:bulletin][:body]
      @bulletin.user_id       = current_user.id

      assign_author(params[:bulletin][:author_id], params[:bulletin][:author_type])

      if @bulletin.save
        render json: @bulletin
      else
        render json: { errors: @bulletin.errors.messages }, status: 500
      end
    else
      render json: @bulletin
    end


  end

private
  def assign_author(id, type)
    # if author_type is User, verify that the id is the same as the current user's id
    if type == 'User' && id == current_user.id
      @bulletin.author_id   = current_user.id
      @bulletin.author_type = type
    end

    # if the author_type is an Organization
    # make sure the current user is a member of that organization
    # and then assign that organization as the author
    if type == 'Organization'
      organization = Organization.find(id)
      if organization && current_user.is_member_of?(organization)
        @bulletin.author_id = organization.id
        @bulletin.author_type = 'Organization'
      end
    end
  end
end