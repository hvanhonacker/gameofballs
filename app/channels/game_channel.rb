class GameChannel < ApplicationCable::Channel
  def subscribed
    @game = Game.find(params[:game])

    stream_from "game_channel:#{params[:game]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed

    Rails.logger.debug "unsubscribed"
  end

  def receive(data)
    rendered_reaction = ApplicationController.renderer.render(partial: 'game_events/reaction', locals: { reaction: data["reaction"] })
    ActionCable.server.broadcast "game_channel:#{@game.id}", content: rendered_reaction
  end
end
