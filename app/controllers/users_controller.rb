class UsersController < ApplicationController
  before_action :require_login, only: [:show, :edit, :update]

  def edit
    @user = User.find(@current_user.id)
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
    render layout: false if request.xhr?
  end

  def show
    @boxes = Box.by_user(@current_user)
    @winning_boxes = Box.where(is_winner: true)
    user_games = Game.by_id(@boxes.pluck(:game_id).uniq)
    @entered_user_games = user_games.created
    @active_user_games = user_games.active
    @complete_user_games = user_games.active
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(edit_user_params)
      flash[:error] = 'Saved your info'
      redirect_to user_path(@current_user)
    else
      flash[:error] = @user.errors.full_messages.first
      redirect_to :back
    end
  end

  private

  def edit_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
