class Player < ActiveRecord::Base
  has_many :sessions
  has_many :games
  validates :name, presence: true
end