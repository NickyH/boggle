class CreateGamesTable < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.string :best_word, :default => 'na'
      t.string :letters
      t.boolean :is_active
      t.timestamps
    end
  end
end
