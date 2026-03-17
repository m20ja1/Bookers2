class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_user

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end




end
