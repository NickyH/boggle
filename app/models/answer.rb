# == Schema Information
#
# Table name: answers
#
#  id       :integer          not null, primary key
#  word     :string(255)
#  is_valid :boolean
#  game_id  :integer
#

class Answer < ActiveRecord::Base
  attr_accessible :word, :is_valid, :game_id
  belongs_to :game
  belongs_to :user
end
