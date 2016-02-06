class BoxUpdater
  def self.update!(game)
    array_of_quarter_names = %w(first_quarter second_quarter third_quarter fourth_quarter).freeze
    game.lock!
    make_all_boxes_false(game.boxes.winners)
    array_of_quarter_names.each do |quarter|
      next if game["#{quarter}_home_score"].nil?
      home_score_num = game["#{quarter}_home_score"] % 10
      away_score_num = game["#{quarter}_away_score"] % 10
      update_winning_box_and_winner(game.boxes.by_winning_scores(home_score_num, away_score_num).first, game, quarter)
    end
    game.save!
  end

  private

  def self.make_all_boxes_false(boxes)
    boxes.each do |box|
      box.update(is_winner: false)
    end
  end

  def self.update_winning_box_and_winner(box, game, quarter)
    box.lock!
    winning_user = box.user
    game["#{quarter}_winner"] = if winning_user.nil?
                                  'None'
                                else
                                  winning_user.name
    end
    box.is_winner = true
    box.save!
  end
end
