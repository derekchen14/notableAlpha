class MainController < ApplicationController
  def home
  	if user_signed_in?
      sort_criteria = cookies[:sort_criteria] || "position"
      @note = current_user.notes.build
      @notes = current_user.notes.order(sort_criteria) 
      @recent_notes = current_user.notes.recent_notes
      @tags = current_user.tags
    end
  end

end
