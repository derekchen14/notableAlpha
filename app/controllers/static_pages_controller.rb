class StaticPagesController < ApplicationController
  def home
  	if signed_in?
      @note = current_user.notes.build
      #@notebook_items = current_user.notebook.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end

end
