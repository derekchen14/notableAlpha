require 'text/text_util'

class RemindersController < ApplicationController
	def new
		@reminder = Reminder.new
	end

	def create
		p params
		respond_to do |format|
			format.html { redirect_to root_url }
			format.json do
				Texter.send_text(current_user.sendhub_id, params[:reminder][:content])
				render :json => {},
				:status => :ok
				end

		end	
	end

end
