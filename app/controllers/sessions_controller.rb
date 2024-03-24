# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def new
    return redirect_to events_path if session[:user_id].present?

    @user = User.new
  end

  def create
    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to events_path
    else
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end

  private

  def user
    return @user if defined?(@user)

    @user = User.find_by(email: session_params[:email])
  end

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
