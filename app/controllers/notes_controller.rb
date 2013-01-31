require 'text/text_util'

class NotesController < ApplicationController
	before_filter :signed_in_user
	before_filter :correct_user,   only: :destroy

	def create
    @note = current_user.notes.build(params[:note])
    btn_text = params[:commit]
    if @note.save
      if btn_text == "Post"
        flash[:success] = "Note created!"
        redirect_to root_url
      elsif btn_text == "Set Reminder" 
        if current_user.sendhub_id.nil?
          flash[:error] = "Please add a phone number first."        
          redirect_to edit_user_path(current_user)
        else
          set_reminder
          redirect_to root_url
        end
      end
    else
      @notebook_items = []
      render 'static_pages/home'
    end
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

    def set_reminder
      if Texter.send_text(current_user.sendhub_id, @note.content)
        flash[:success] = "Reminder sent to your phone."
      else
        flash[:error] = "Failed to set a reminder."
      end
    end

end
