class Admin::GamesController < ApplicationController
  before_action :require_admin
  before_filter :check_for_new_cancel, :only => [:create]
  before_filter :check_for_edit_cancel, :only => [:update]


  def create
    @game = Game.new(game_params)

    if @game.save
      flash[:success] = "Game saved!"
      redirect_to root_path
    else
      flash[:error] = "Game not saved"
      redirect_to :back
    end
  end

  def destroy
    if Game.find(params[:id]).destroy
      flash[:success] = "Game deleted"
      redirect_to root_path
    else
      flash[:error] = "Game not deleted"
      redirect_to :back
    end
  end

  def new
    @game = Game.new
  end

private
#TODO: GET RID OF THIS METHOD
  def check_for_new_cancel
    if params[:cancel] == "Cancel"
      redirect_to root_path
    end
  end
#TODO: GET RID OF THIS METHOD
  def check_for_edit_cancel
    if params[:cancel] == "Cancel"
      redirect_to game_path
    end
  end

  def game_params
    params.require(:game).permit(:away_team, :home_team)
  end
end
