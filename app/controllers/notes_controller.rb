require 'text/text_util'

class NotesController < ApplicationController
	before_filter :authenticate_user!
	before_filter :correct_user,   only: :destroy

  respond_to :html, :json
  

	def create
    @note = current_user.notes.build(params[:note])
    if params[:note][:content].blank?
      flash[:error] = "Note cannot be empty."
    elsif @note.save
      @note.move_to_top
    else
      flash[:error] = "Note was not saved correctly."
    end
    redirect_to root_url
	end

  def edit
    @note = current_user.notes.find(params[:id])
  end

  def update
    @note = current_user.notes.find(params[:id])
    @note.update_attributes(params[:note])
    respond_with_bip @note
  end
	
  def destroy
    @note.destroy
    redirect_to root_url
	end

  def index
  end

  def sort
    params[:note].each_with_index do |id, index|
      Note.update_all({position: index+1}, {id: id})
    end
    render nothing: true    
  end

	private
    def correct_user
      @note = current_user.notes.find_by_id(params[:id])
      redirect_to root_url if @note.nil?
    end
    
end
