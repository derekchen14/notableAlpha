class TagsController < ApplicationController
  # before_filter :assign_user, only: [:new, :create]

  def index
    @tags = current_user.tags.order(:name)
    respond_to do |format|
      format.html
      format.json { render json: @tags.tokens(params[:q]) }
    end
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(params[:tag])
    if @tag.save
      redirect_to tags_path
    else
      render :new
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update_attributes(params[:tag])
      redirect_to @tag
    else
      render :edit
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
  end
  
  private

  def assign_user
  end
end
