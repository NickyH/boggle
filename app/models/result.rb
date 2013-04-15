# == Schema Information
#
# Table name: results
#
#  id         :integer          not null, primary key
#  game_id    :integer
#  user_id    :integer
#  score      :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Result < ActiveRecord::Base
  attr_accessible :score
  belongs_to :user
  belongs_to :game
  has_many :answers
end
