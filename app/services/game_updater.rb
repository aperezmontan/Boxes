class GameUpdater
  def self.update!(game_to_update, new_score)
    game_to_update.lock!
    game_to_update["#{new_score.quarter}_home_score"] = new_score.home_score
    game_to_update["#{new_score.quarter}_away_score"] = new_score.away_score
    game_to_update.status = "ACTIVE" if game_to_update.status == "CREATED"
    game_to_update.status = "COMPLETED" if new_score.is_final
    game_to_update.save!
    BoxUpdater.update!(game_to_update)
  end
end
