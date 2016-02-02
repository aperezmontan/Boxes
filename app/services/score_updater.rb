class ScoreUpdater
  def self.update!(new_score)
    update_all_scores(new_score)
    call_game_updater_on_relevant_games(new_score)
  end

  private

  def self.call_game_updater_on_relevant_games(new_score)
    Game.by_description(new_score.game_info).each do |game|
      GameUpdater.update!(game, new_score)
    end
  end

  def self.update_all_scores(new_score)
    Score.current.each do |current_score|
      if current_score.game_info == new_score.game_info
        current_score.status = 1
        current_score.save #-----Add some error checking here
      end
    end
  end
end