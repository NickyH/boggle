# == Schema Information
#
# Table name: games
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  score          :integer
#  best_word      :string(255)
#  current_player :string(255)
#  is_active      :boolean
#  user_id        :integer
#

class Game < ActiveRecord::Base
  attr_accessible :name, :score, :best_word, :user_id, :current_player, :is_active
  has_many :answers
  has_many :users
end

