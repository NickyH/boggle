class CreateAnswersTable < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :word
      t.boolean :is_valid
      t.boolean :is_taken, :default => true
      t.integer :game_id
      t.integer :user_id
    end
  end
end
