class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.integer :home_team_num
      t.integer :away_team_num
      t.boolean :winner?
      t.string  :win_type

      t.timestamps null: false
    end
  end
end
