class GameEventsController < ApplicationController
  before_action :load_game

  def create
    broadcast_ball_went_in_pocket(params[:ball_number])

    head :ok
  end

  private

  def load_game
    @game = Game.find(params[:game_id])
  end

  def broadcast_ball_went_in_pocket(ball_number)
    ActionCable.server.broadcast "game_channel:#{@game.id}", content: render_game_event("La boule #{ball_number} est rentrée")
  end

  def render_game_event(text)
    render(partial: 'game_event', locals: { text: text })
  end
end
