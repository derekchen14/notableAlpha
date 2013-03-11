class CustomFailure < Devise::FailureApp
  def recall 
    env["PATH_INFO"] = attempted_path
    flash.now[:error] = i18n_message(:invalid)
    # flash.now[:error] = "Invalid email or password"
    self.response = recall_app(warden_options[:recall]).call(env)
  end
end
