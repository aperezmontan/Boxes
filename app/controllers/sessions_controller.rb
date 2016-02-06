class SessionsController < ApplicationController
  before_action :check_for_new_user, only: [:create]

  def new
  end

  def create
    user = User.where('name = ? OR email = ?', session_params[:login], session_params[:login]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:error] = 'Either username or password are incorrect.'
      redirect_to signin_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to signin_path
  end

  private

  def session_params
    params.permit(:login, :password, :signup)
  end

  def check_for_new_user
    redirect_to new_user_path if session_params[:signup]
  end
end
