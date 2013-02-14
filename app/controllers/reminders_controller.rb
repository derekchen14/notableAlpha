require 'text/text_util'

class RemindersController < ApplicationController
	def new
		@reminder = Reminder.new
	end

	def create
		respond_to do |format|
			format.html { redirect_to root_url }
			format.js
		end	
	end

end
