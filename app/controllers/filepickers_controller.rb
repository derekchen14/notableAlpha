class FilepickersController < ApplicationController

	def new
	end

	def create
		respond_to do |format|
			format.html { redirect_to root_url }
			format.json { save_url }
		end	
	end

	private
		def save_url
			note_id = params[:filepicker][:note_id]
			filepicker_url = params[:filepicker][:url]	

			filepicker_url.split(",").each do |url|
				NotableFilepicker.create(note_id: note_id, url: url)
			end
		end

end
