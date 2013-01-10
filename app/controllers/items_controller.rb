class ItemsController < ApplicationController
	before_filter :signed_in_user
	before_filter :correct_user,   only: :destroy

	def create
		@item = item.new(params[:item])
	end

	def destroy
		@item.destroy
    redirect_to root_url
	end

  def update
  end

  def show
		@item = current_user.note.item
  end

	private
    def correct_user
      @note = current_user.notes.find_by_id(params[:id])
      redirect_to root_url if @note.nil?
    end

end
