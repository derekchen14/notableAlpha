class StaticPagesController < ApplicationController
  def home
  	if signed_in?
      @note = current_user.notes.build
      @notes = current_user.notes.paginate(page: params[:page])
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
