require 'text/text_util'
require 'json'

class UsersController < ApplicationController
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: [:destroy, :index]
  before_filter :already_member, only: [:new, :create]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @notes = @user.notes.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to Notable!"
      sign_in @user      
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    btn_text = params[:commit]
    if update_success
      sign_in @user
      if btn_text == 'Add'
        redirect_to root_path
      else
        redirect_to @user
      end
    else
      sign_in @user
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User successfully removed."
    redirect_to users_url
  end

  private
    def update_success
      if params[:user][:phone_number].blank?
        unless @user.phone_number.nil? 
          delete_reminder_id
        end
      elsif params[:user][:phone_number]
        if @user.phone_number.nil? 
          create_reminder_id 
        else 
          edit_reminder_id
        end
      end
    end

      def create_reminder_id
      if @user.update_attributes(params[:user])
        puts "create section"
        res = Texter.add_contact(@user.username, @user.phone_number)
        if res.code == '201'
          response_body = JSON.parse(res.body)
          @user.update_attributes(sendhub_id: response_body['id'])
          flash[:success] = "Profile successfully updated."
          return true
        else 
          flash[:error] = "Phone number not added. Please try again later."
          return false
        end
      end
    end
    
    def edit_reminder_id
      if @user.update_attributes(params[:user])
        puts "edit section"
        res = Texter.edit_contact(@user.username, @user.phone_number, @user.sendhub_id)
        puts res.body
        if res.code == '202'
          response_body = JSON.parse(res.body)
          flash[:success] = "Profile successfully updated."
          return true
        else 
          flash[:error] = "Phone number not updated. Please try again later."
          return false
        end
      end
    end
    
    def delete_reminder_id
      res = Texter.delete_contact(@user.sendhub_id)
      if res.code == '204'
        @user.update_attributes(:phone_number => nil)
        @user.update_attributes(:sendhub_id => nil)
        flash[:success] = "Profile successfully updated."
        return true
      else 
        flash[:error] = "Phone number not removed. Please try again later."
        return false
      end
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def already_member
      if user_signed_in?
       redirect_to root_url
      end
    end

end
