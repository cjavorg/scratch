class Word < ActiveRecord::Base
  validates :text, presence: true, length: { is: 5 }
  validates :text, uniqueness: true

  has_many :games
end
