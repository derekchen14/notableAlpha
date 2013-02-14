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
    if @user.update_attributes(params[:user])
      set_reminder_id
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
      res = Texter.add_contact(@user.username, @user.phone_number)
      if res.code == '201'
        response_body = JSON.parse(res.body)
        @user.update_attributes(sendhub_id: response_body['id'])
        flash[:success] = "Profile successfully updated."
      else 
        flash[:error] = "Phone number not added. Please try again later."
      end
        sign_in @user
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
