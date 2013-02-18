require 'text/text_util'
require 'json'

class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index, 
    :destroy, :following, :followers]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
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
    
    if (@user.phone_number.nil? || @user.phone_number.length == 0)
      if (params[:user][:phone_number].nil? || params[:user][:phone_number].length == 0)
        @updateSuccess = @user.update_attributes(params[:user])
      else
        if (set_reminder_id)
          @updateSuccess = @user.update_attributes(params[:user])
        end
      end
    else 
      if (params[:user][:phone_number].nil? || params[:user][:phone_number].length == 0)
        if (delete_reminder_id)
          @updateSuccess = @user.update_attributes(params[:user])
        end
      else
        if (edit_reminder_id)
          @updateSuccess = @user.update_attributes(params[:user])
        end
      end
    end
    sign_in @user
    if (@updateSucess)
      if btn_text == 'Add'
        redirect_to root_path
      else
        redirect_to @user
      end
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User successfully removed."
    redirect_to users_url
  end

  private
    def set_reminder_id
      res = Texter.add_contact(params[:user][:username], params[:user][:phone_number])
      if res.code == '201'
        response_body = JSON.parse(res.body)
        @user.update_attributes(sendhub_id: response_body['id'])
        flash[:success] = "Profile successfully updated."
        return true
      else 
        flash[:error] = "Profile failed to be modified. Please try again later."
        return false
      end
    end
    
    def edit_reminder_id
      res = Texter.edit_contact(params[:user][:username], params[:user][:phone_number], @user.sendhub_id)
      if res.code == '202'
        response_body = JSON.parse(res.body)
        flash[:success] = "Profile successfully updated."
        return true
      else 
        flash[:error] = "Profile failed to be modified. Please try again later."
      end
    end
    
    def delete_reminder_id
      res = Texter.delete_contact(@user.sendhub_id)
      @user.update_attributes(:sendhub_id => nil)
      if res.code == '204'
        flash[:success] = "Profile successfully updated."
        return true
      else 
        flash[:error] = "Profile failed to be modified. Please try again later."
        return false
      end
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def already_member
      if signed_in?
       redirect_to root_url
      end
    end

end
