class UsersController < ApplicationController
  before_action :require_login, only: [:show]

  def show
    @player = Player.where(id: current_user.id)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:error] = @user.errors.full_messages.first
      render :new
    end
  end

  def new
    @user = User.new
  end

private

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end
