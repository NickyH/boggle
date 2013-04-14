class CreateAnswersTable < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :word
      t.boolean :is_valid
      t.integer :game_id
      t.integer :user_id
    end
  end
end
