class RegistrationsController < Devise::RegistrationsController
  before_filter :admin_user, only:[:destroy, :index]
  before_filter :authenticate_user!

  def index
    super 
  end
  
  def new 
    super
  end

  def create
    build_resource

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :success, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def edit
    super
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    btn_text = params[:commit]
    if update_success
      if btn_text == 'Add'
        redirect_to root_path
      else
        redirect_to resource
      end
    else
      render 'edit'
      flash[:error] = "Profile not updated."
    end

  end

  def destroy
    super
  end

  private

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end


  def update_success
    phone = params[:user][:phone_number]

    if resource.phone_number.blank? && !phone.blank?
      create_reminder_id
    elsif !resource.phone_number.blank? && phone.blank?
      delete_reminder_id
    elsif !resource.phone_number.blank? && !phone.blank?
      edit_reminder_id
    else
      resource.update_attributes(params[:user])
      flash[:success] = "Profile successfully updated."
    end

  end

  def create_reminder_id
    if resource.update_attributes(params[resource_name])
      res = Texter.add_contact(resource.username, resource.phone_number)
      if res.code == '201'
        response_body = JSON.parse(res.body)
        resource.update_attributes(sendhub_id: response_body['id'])
        flash[:success] = "Phone number successfully added."
        return true
      else 
        flash[:error] = "Phone number not added. Please try again later."
        return false
      end
    end
  end

  def edit_reminder_id
    if resource.update_attributes(params[resource_name])
      res = Texter.edit_contact(resource.username, resource.phone_number, resource.sendhub_id)
      if res.code == '202'
        response_body = JSON.parse(res.body)
        flash[:success] = "Phone number successfully updated."
        return true
      else 
        flash[:error] = "Phone number not updated. Please try again later."
        return false
      end
    end
  end

  def delete_reminder_id
    res = Texter.delete_contact(resource.sendhub_id)
    if res.code == '204'
      resource.update_attributes(:phone_number => "")
      resource.update_attributes(:sendhub_id => nil)
      flash[:success] = "Phone number successfully removed."
      return true
    else 
      flash[:error] = "Phone number not removed. Please try again later."
      return false
    end
  end

end
