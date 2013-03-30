class StaticPagesController < ApplicationController
  def home
  	if user_signed_in?
      sort_criteria = cookies[:sort_criteria] || "position"
      @note = current_user.notes.build
      @notes = current_user.notes.order(sort_criteria) 
      @tags = Tag.all
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def settings
  end

end
