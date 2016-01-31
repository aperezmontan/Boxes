class GamePresenter
  def initialize(game, template)
    @game = game
    @template = template
  end

  def away_numbers
    numbers_array = @game.boxes.by_home_team_coord("A").pluck(:away_team_num)
    numbers_array.unshift("")
  end

  def home_numbers
    numbers_array = @game.boxes.by_away_team_coord("A").pluck(:home_team_num)
    numbers_array.unshift("")
  end

  def away_letters
    letters_array = @game.boxes.by_home_team_coord("A").pluck(:away_team_coord)
    letters_array.unshift("")
  end

  def home_letters
    letters_array = @game.boxes.by_away_team_coord("A").pluck(:home_team_coord)
    letters_array.unshift("")
  end
end