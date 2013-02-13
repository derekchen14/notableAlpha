class RemindersController < ApplicationController
	def new
		@reminder = Reminder.new
	end

	def create
		puts "Connected to the RemindersController"
		respond_to do |format|
			format.html { redirect_to root_url }
			format.js
		end
    # if Texter.send_text(current_user.sendhub_id, @note.content)
    #   flash[:success] = "Reminder sent to your phone."
    # else
    #   flash[:error] = "Failed to set a reminder."
    # end
	end

end
