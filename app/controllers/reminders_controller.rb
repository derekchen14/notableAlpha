require 'text/text_util'

class RemindersController < ApplicationController
	def new
		@reminder = Reminder.new
	end

	def create
		flash.now[:success] = "A reminder will be sent soon."
		flash[:success] = "Aniother antetp"
		respond_to do |format|
			format.html { redirect_to root_url }
			format.json { send_reminder }
		end	
	end


	private

		def send_reminder
			length = params[:reminder][:length]
			if Texter.send_text(current_user.sendhub_id, params[:reminder][:content])
				flash.now[:success] = "A reminder will be sent soon."
				puts "this are works"
			else
				flash[:error] = "Failed to set a reminder."
			end
			render json: flash[:success], status: :ok			
		end

end
