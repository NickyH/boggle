class CreateAnswersTable < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :word
      t.boolean :is_valid
      t.boolean :is_taken, :default => false
      t.integer :game_id
      t.timestamps
    end
  end
end
