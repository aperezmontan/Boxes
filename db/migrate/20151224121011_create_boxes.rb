class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.string :home_team_coord
      t.string :away_team_coord
      t.integer :home_team_num
      t.integer :away_team_num
      t.boolean :is_winner
      t.references :game
      t.references :user

      t.timestamps null: false
    end
  end
end
