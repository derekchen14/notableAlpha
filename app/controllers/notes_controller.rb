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
      elsif btn_text == "Set Reminder" 
        puts "part one"
        if Texter.send_text(current_user.sendhub_id, @note.content)
          puts "part two"
          flash[:success] = "Note texted to your phone."
        else
          flash[:error] = "Failed to text your phone."
        end
        puts "part three"
      end
      redirect_to root_url
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

end
