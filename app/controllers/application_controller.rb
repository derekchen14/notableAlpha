class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  after_filter :flash_headers

  private
	  def flash_headers
	  	return unless request.xhr?
	  	# This will discontinue execution if Rails detects that the 
	  	# request is not from an AJAX request
	  	response.headers['x-flash'] = flash_message
      response.headers['x-flash-type'] = flash_type.to_s
		  
		  flash.discard # Stops the flash appearing when you refresh the page
		end

    def flash_message
      [:error, :warning, :notice, :success].each do |type|
        return flash_type = flash[type].blank? ? "" : flash[type]
      end
    end

		def flash_type
			[:error, :warning, :notice, :success].each do |type|
				return type unless flash[type].blank?
			end
		end

end
