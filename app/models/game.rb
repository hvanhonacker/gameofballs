class Game < ApplicationRecord
  validates :player_1_name, presence: true
  validates :player_2_name, presence: true

  def ball_went_in_pocket(ball_id)
    broadcast_ball_went_in_pocket(ball_id)
  end

  private

  def broadcast_ball_went_in_pocket(ball_id)
    ActionCable.server.broadcast 'game_channel', event_text: "La boule #{ball_id} est rentrée"
  end
end
