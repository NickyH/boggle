class CreateGamesTable < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.integer :score
      t.string :best_word
      t.string :current_player
      t.boolean :is_active
      t.integer :user_id
    end
  end
end