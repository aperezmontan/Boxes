class GamesController < ApplicationController
  before_action :require_login
  before_filter :check_for_new_cancel, :only => [:create]
  before_filter :check_for_edit_cancel, :only => [:update]

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
  end
end
