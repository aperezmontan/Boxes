#TODO make this much better and part of middleware stack

class GameUpdater
  def self.update!(new_score)
    Game.all.each do |game|
      if game.game_info == new_score.game_info
        box = game.boxes.by_home_score_num(new_score.home_score % 10).by_away_score_num(new_score.away_score % 10).first
        box.is_winner = true
        box.save
      end
    end
  end
end