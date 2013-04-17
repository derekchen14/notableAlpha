class ItemsController < ApplicationController
	before_filter :authenticate_user!

	def create
		@item = item.new(params[:item])
	end

	def destroy
		@item.destroy
    redirect_to root_url
	end

  def update
    respond_to do |format|
      format.json do
        @item = Item.find(params[:item][:id]);  
        @item.update_attributes(params[:item]);
        render nothing: true
      end
    end
  end

  def show
    @item = Item.find(params[:id]);  
    respond_to do |format|
      format.json  { render :json => @item }
    end
  end

	private
    def correct_user
      @note = current_user.notes.find_by_id(params[:id])
      redirect_to root_url if @note.nil?
    end

end
