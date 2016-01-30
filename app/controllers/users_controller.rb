class UsersController < ApplicationController
  before_action :require_login, only: [:show]

  def show
    @boxes = Box.by_user(@current_user)
    @winning_boxes = Box.where(:is_winner => true)
    user_games = Game.by_id(@boxes.pluck(:game_id).uniq)
    @not_active_user_games = user_games.not_active
    @active_user_games = user_games.active
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
    if request.xhr?
      render layout: false
    end
  end

private

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end
