class SessionsController < ApplicationController
  #skip_before_action :authenticate_user!, only: [:new, :create]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
  end


  def create

      if (user = User.find_by(name: params[:name]))&.authenticate(params[:password])
         start_new_session_for user
        redirect_to after_authentication_url, notice: "Signed in successfully."

    else
      flash.now[:alert] = "Try another name or password."
      render :new, status: :unprocessable_entity
    end
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Signed out successfully."
  end
end
