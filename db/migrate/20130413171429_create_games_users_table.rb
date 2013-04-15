class CreateGamesUsersTable < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :game_id
      t.integer :user_id
      t.integer :score, :default => 0
      t.timestamps
    end
  end
end
