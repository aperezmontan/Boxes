class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string  :home_team
      t.string  :away_team
      t.text    :first_quarter
      t.text    :second_quarter
      t.text    :third_quarter
      t.text    :final
      t.boolean :is_active

      t.timestamps null: false
    end
  end
end
