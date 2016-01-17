class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.where("name = ? OR email = ?", params[:login], params[:login]).first
    if (user && user.authenticate(params[:password]))
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:error] = "Either username or password are incorrect."
      redirect_to signin_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to signin_path
  end

end
