class LettersController < ApplicationController
  def index
    @letters = Letter.includes(:voted_users).reverse
  end

  def show
    @letter = Letter.find(params[:id])
    @vote = @letter.votes.new
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @letter }
    end
  end

  def new
    @letter = Letter.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @letter }
    end
  end

  def edit
    @letter = Letter.find(params[:id])
  end

  def create
    # @letter = current_user.letters.build(params[:letter])
    # respond_to do |format|
    #   if @letter.save
    #     format.html { redirect_to letters_path, notice: 'Letter was successfully created.' }
    #     format.json { render json: letters_path, status: :created, location: @letter }
    #   else
    #     format.html { render action: "new" }
    #     format.json { render json: @letter.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def update
    @letter = Letter.find(params[:id])
    respond_to do |format|
      if @letter.update_attributes(params[:letter])
        format.html { redirect_to letters_path notice: 'Letter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @letter.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @letter = Letter.find(params[:id])
    @letter.destroy

    respond_to do |format|
      format.html { redirect_to letters_url }
      format.json { head :no_content }
    end
  end
end
