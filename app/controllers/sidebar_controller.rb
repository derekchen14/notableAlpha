class SidebarController < ApplicationController
	before_filter :authenticate_user!

  def short_notes
    @notes = current_user.notes 
  end

  def recent_notes
    @notes = current_user.notes.recent_notes
    render "short_notes"
  end

  def select_note
    @note = current_user.notes.find(params[:id])
    respond_to do |format|
      format.js { render template: "notes/select_note" }
    end
  end
end
