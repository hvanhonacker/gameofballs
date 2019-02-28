class GameEventsController < ApplicationController
  before_action :load_game

  def create
    @game.ball_went_in_pocket(params[:ball_number])

    head :ok
  end

  private

  def load_game
    @game = Game.find(params[:game_id])
  end
end
