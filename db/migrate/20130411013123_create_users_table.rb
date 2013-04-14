class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.integer :high_score, :default => 0
      t.string :channel
      t.boolean :is_online, :default => false
    end
  end
end