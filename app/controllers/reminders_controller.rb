require 'text/text_util'

class RemindersController < ApplicationController
	def new
		@reminder = Reminder.new
	end

	def create
		respond_to do |format|
			format.html { redirect_to root_url }
			format.json { send_reminder }
			format.js
		end	
	end


	private

		def send_reminder
			length = params[:reminder][:length]
			if Texter.send_text(current_user.sendhub_id, params[:reminder][:content])
				flash.now[:success] = "A reminder will be sent soon."
				p params
			else
				flash[:error] = "Failed to set a reminder."
			end
			render json: {}, status: :ok			
		end

end
