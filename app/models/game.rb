# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  best_word  :string(255)
#  letters    :string(255)
#  is_active  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Game < ActiveRecord::Base
  attr_accessible :name, :best_word, :letters, :is_active
  has_many :answers
  has_many :results
  has_many :users, :through => :results
end
