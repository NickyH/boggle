# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  high_score      :integer          default(0)
#  channel         :string(255)
#  is_online       :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation, :high_score, :channel, :is_online
  has_secure_password
  has_many :games
  has_many :answers

  def current_game
    self.games.where(:is_active => true).last
  end
end
