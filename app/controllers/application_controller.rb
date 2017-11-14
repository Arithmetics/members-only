class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def sign_in(user)
    user.remember
    @token = user.remember_token
    cookies.permanent[:remember_token] = user.remember_token
    current_user
  end

  def sign_out
    @current_user = nil
    cookies[:remember_token] = nil
  end


  def current_user
      @current_user = User.find_by(remember_digest: User.encrypt_token(cookies.permanent[:remember_token]))
  end

  def require_login
    unless current_user
      flash[:error] = "member only!"
      redirect_to login_path
    end
  end 






end
