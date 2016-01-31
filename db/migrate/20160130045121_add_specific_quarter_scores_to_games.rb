class AddNameAndPriceToGames < ActiveRecord::Migration
  def change
    add_column :games, :name, :string
    add_column :games, :price, :integer

    remove_column :games, :first_quarter, :text
    remove_column :games, :second_quarter, :text
    remove_column :games, :third_quarter, :text
    remove_column :games, :final, :text
    remove_column :games, :home_scores, :text
    remove_column :games, :away_scores, :text
  end
end
