class ScoresController < ApplicationController
  before_action :require_login
  before_action :is_editable, only: [:edit]

  def create
    @score = Score.new(score_params)
    if @score.save
      flash[:error] = 'Score saved!'
      redirect_to games_path
    else
      flash[:error] = @score.errors.full_messages.first
      render :back
    end
  end

  def edit
  end

  def new
    @score = Score.new
    @quarter_options = { first_quarter: 1, second_quarter: 2, third_quarter: 3, fourth_quarter: 4 }.to_a.freeze
  end

  def index
    @scores = Score.all
    @games = Game.by_description(@scores.pluck(:game_info))
  end

  def show
    @score = Score.find(params[:id])
    @winning_boxes = []
    # TODO: change winning boxes logic to be found by the score_updater and presented through the score presenter
  end

  def update
    @score = Score.find(params[:id])
    @score.update(score_params)

    if @score.save
      flash[:success] = 'Score saved!'
      redirect_to root_path
    else
      flash[:error] = 'Score not saved'
      redirect_to :back
    end
  end

  private

  def score_params
    params.require(:score).permit(:game_info, :away_score, :home_score, :quarter, :is_final)
  end
end
