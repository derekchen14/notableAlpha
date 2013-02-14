require 'text/text_util'

class RemindersController < ApplicationController
	def new
		@reminder = Reminder.new
	end

	def create
		respond_to do |format|
			format.html { redirect_to root_url }
			format.json { send_reminder }
		end	
	end


	private

		def send_reminder
			timing = params[:reminder][:timing]
			if Texter.send_text(current_user.sendhub_id, params[:reminder][:content])
				flash[:success] = "A reminder will be sent #{timing}."
				render json: flash[:success], status: :ok
			else
				flash[:error] = "Failed to set a reminder."
				render json: flash[:error], status: :unprocessable_entity
			end
		end

end
