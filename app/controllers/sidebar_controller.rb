class SidebarController < ApplicationController
	before_filter :authenticate_user!

  def short_notes
    @notes = current_user.notes 
  end

  def recent_notes
    @notes = current_user.notes.recent_notes
    render "short_notes"
  end
end
