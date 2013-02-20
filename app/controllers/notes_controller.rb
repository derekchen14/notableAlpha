require 'text/text_util'

class NotesController < ApplicationController
	before_filter :signed_in_user
	before_filter :correct_user,   only: :destroy

	def create
    @note = current_user.notes.build(params[:note])
    if params[:note][:content].blank?
      flash[:error] = "Note cannot be empty."
    elsif @note.save
    else
      flash[:error] = "Note was not saved correctly."
    end
    redirect_to root_url
	end

	def destroy
		@note.destroy
    redirect_to root_url
	end

  def index
  end

	private
    def correct_user
      @note = current_user.notes.find_by_id(params[:id])
      redirect_to root_url if @note.nil?
    end
    
end
