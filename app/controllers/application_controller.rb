class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  after_filter :flash_headers

  private
	  def flash_headers
	  	return unless request.xhr?
	  	# This will discontinue execution if Rails detects that the 
	  	# request is not from an AJAX request
		  response.headers['x-flash'] = flash[:error]  unless flash[:error].blank?
		  response.headers['x-flash'] = flash[:success]  unless flash[:success].blank?
		  response.headers['x-flash'] = flash[:notice]  unless flash[:notice].blank?
		  # Stops the flash appearing when you next refresh the page
		  flash.discard
		end

end
