class ApplicationController < ActionController::Base
  before_action :authenticate_user

  private

  attr_reader :current_user

  def authenticate_user
    return redirect_to root_path if session[:user_id].blank?

    user = User.find_by(id: session[:user_id])

    if user.blank?
      session.delete(:user_id)
      return redirect_to root_path
    end

    @current_user = user
  end
end
