require 'text/text_util'

class NotesController < ApplicationController
	before_filter :authenticate_user!
	before_filter :correct_user,   only: :destroy

  respond_to :html, :json
  

	def create
    @note = current_user.notes.build(params[:note])
    if params[:note][:content].blank?
      flash[:error] = "Note cannot be empty."
    elsif @note.save
      @note.move_to_top
    else
      flash[:error] = "Note was not saved correctly."
    end
    redirect_to root_url
	end

  def edit
    @note = current_user.notes.find(params[:id])
  end

  def update
    @note = current_user.notes.find(params[:id])
    @note.update_attributes(params[:note])
    respond_with_bip @note
  end
	
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to root_url}
      format.js
    end
	end

  def index
  end
  
  def duplicate
    @note = current_user.notes.find(params[:id]).dup
    @note.content = @note.content + " (copy)"
    @note.save
    respond_to do |format|
      format.html { redirect_to root_url}
      format.js
    end
  end

  def sort
    params[:note].each_with_index do |id, index|
      Note.update_all({position: index+1}, {id: id})
    end
    render nothing: true    
  end

  def sort_by
    @notes = current_user.notes.order(params[:criteria])
    cookies[:sort_criteria] =  params[:criteria]
    respond_to do |format| 
      format.js { render action: "custom_sort"}
    end
  end

  # def sort_date
  #   @notes = current_user.notes.order("created_at desc")
  #   cookies[:sort_criteria] = "created_at desc"
  #   respond_to do |format| 
  #     format.js { render action: "custom_sort"}
  #   end
  # end

  # def sort_date_updated
  #   @notes = current_user.notes.order("updated_at desc")
  #   cookies[:sort_criteria] = "updated_at desc"
  #   respond_to do |format| 
  #     format.js { render action: "custom_sort"}
  #   end
  # end

  # def sort_a_z 
  #   @notes = current_user.notes.order("lower(content) asc")
  #   cookies[:sort_criteria] = "lower(content) asc"
  #   respond_to do |format| 
  #     format.js { render action: "custom_sort"}
  #   end
  # end

  # def sort_z_a
  #   @notes = current_user.notes.order("lower(content) desc")
  #   cookies[:sort_criteria] = "lower(content) desc"
  #   respond_to do |format| 
  #     format.js { render action: "custom_sort"}
  #   end
  # end

  # def sort_position
  #   @notes = current_user.notes.sort_by{ |n| n.position}
  #   cookies[:sort_criteria] = "position"
  #   respond_to do |format| 
  #     format.js { render action: "custom_sort"}
  #   end
  # end

	private
    def correct_user
      @note = current_user.notes.find_by_id(params[:id])
      redirect_to root_url if @note.nil?
    end
    
end
