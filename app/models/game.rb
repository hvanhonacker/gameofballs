class Game < ApplicationRecord
  validates :player_1_name, presence: true
  validates :player_2_name, presence: true
end
