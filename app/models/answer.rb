# == Schema Information
#
# Table name: answers
#
#  id         :integer          not null, primary key
#  word       :string(255)
#  is_valid   :boolean
#  is_taken   :boolean          default(FALSE)
#  result_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Answer < ActiveRecord::Base
  attr_accessible :word, :is_valid, :is_taken, :game_id
  belongs_to :result
end
