class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :admin?
  helper_method :mobile_device?

  before_action :check_for_mobile
  before_action :prepare_for_mobile

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  private

  def box_available?
    if params[:box_type] == 'Locked'
      flash[:error] = 'Box already taken'
      redirect_to :back
    end
  end

  def check_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    prepare_for_mobile if mobile_device?
  end

  def logged_in?
    current_user != nil
  end

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      (request.user_agent =~ /Mobile|webOS/) && (request.user_agent !~ /iPad/)
    end
  end

  def prepare_for_mobile
    request.format = :mobile if mobile_device?
  end

  def require_admin
    unless current_user.role == 'admin'
      flash[:error] = 'You must be an admin user.'
      redirect_to root_path
    end
  end

  def require_login
    unless logged_in?
      flash[:error] = 'Please sign in.'
      redirect_to signin_path
    end
  end

  protected

  def admin?
    false
  end
end
