class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_in_path_for(resource)
    user_path(resource) # ログイン後のリダイレクト先
  end

  def after_sign_out_path_for(resource)
    root_path # ログアウト後のリダイレクト先
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :name, :profile_image])
  end
end
