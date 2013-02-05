require 'text/text_util'

class NotesController < ApplicationController
	before_filter :signed_in_user
	before_filter :correct_user,   only: :destroy

	def create
    @note = current_user.notes.build(params[:note])
    btn_text = params[:commit]
    if @note.save
      set_reminder
=begin      
      flash[:success] = "Note created!"
      redirect_to root_url

      <%= link_to "Remind Me", '#', class: "btn pull-right remind" %>
=end
    else
      @note = []
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
      if current_user.sendhub_id.nil?
        flash[:error] = "Please add a phone number first."        
        redirect_to edit_user_path(current_user)
      else
        if Texter.send_text(current_user.sendhub_id, @note.content)
          flash[:success] = "Reminder sent to your phone."
        else
          flash[:error] = "Failed to set a reminder."
        end
        redirect_to root_url
      end
    end

end
