class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= Player.find_by_id(session[:user_id])
  end

private

  def logged_in?
    current_user != nil
  end

  def require_login
    unless logged_in?
      flash[:error] = "Please sign in."
      redirect_to signin_path
    end
  end

  def require_admin
    unless current_user.is_admin?
      flash[:error] = "You must be an admin user."
      redirect_to session.delete(:return_to)
    end
  end
end
