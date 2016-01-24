class GamesController < ApplicationController
  before_action :require_login
  before_filter :check_for_new_cancel, :only => [:create]

  def edit
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def index
    @active_games = Game.active
    @not_active_games = Game.not_active
    @user_boxes = Box.by_user(@current_user)
  end

  def show
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    @game.update(game_params)

    if @game.save
      flash[:success] = "Game saved!"
      redirect_to root_path
    else
      flash[:error] = "Game not saved"
      redirect_to :back
    end
  end

private

  def game_params
    params.require(:game).permit(:away_team, :home_team, :boxes_attributes => [:id, :is_taken])
  end
end
