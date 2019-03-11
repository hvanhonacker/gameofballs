class GameChannel < ApplicationCable::Channel
  def subscribed
    @game = Game.find(params[:game])

    stream_from "game_channel:#{@game.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed

    Rails.logger.debug "unsubscribed"
  end

  # def receive(data)
  #   rendered_reaction = ApplicationController.renderer.render(partial: 'game_events/reaction', locals: { reaction: data["reaction"] })
  #   ActionCable.server.broadcast "game_channel:#{@game.id}", event_type: :reaction, content: rendered_reaction
  # end

  def reaction(data)
    ActionCable.server.broadcast "game_channel:#{@game.id}", event_type: :reaction, content: data["reaction"]
  end

  def ball_in_the_pocket(data)
    rendered_game_event = ApplicationController.renderer.render(
      partial: 'game_events/event',
      locals: {
        ball_number: data["ball_number"]
      })

    ActionCable.server.broadcast "game_channel:#{@game.id}", event_type: :ball_in_the_pocket, content: rendered_game_event
  end

  def new_turn(data)
    rendered_game_event = ApplicationController.renderer.render(
      partial: 'game_events/turn',
      locals: {
        player_name: data["player"],
        rule: Game.random_rule
      })

    ActionCable.server.broadcast "game_channel:#{@game.id}", event_type: :new_turn, content: rendered_game_event
  end
end
