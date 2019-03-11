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
    rendered_reaction = ApplicationController.renderer.render(partial: 'game_events/reaction', locals: { reaction: data["reaction"] })
    ActionCable.server.broadcast "game_channel:#{@game.id}", event_type: :reaction, content: rendered_reaction
  end

  def ball_in_the_pocket(data)
    rendered_game_event = ApplicationController.renderer.render(partial: 'game_events/game_event', locals: { text: %{La boule <span class='ball ball--#{data["ball_number"]}'>#{data["ball_number"]}</span> est rentrée}.html_safe })
    ActionCable.server.broadcast "game_channel:#{@game.id}", event_type: :ball_in_the_pocket, content: rendered_game_event
  end

  def new_turn(data)
    ActionCable.server.broadcast "game_channel:#{@game.id}", event_type: :new_turn, content: "<li class='event--with-separator'>#{data["player"]} joue</li>"

    rendered_game_event = ApplicationController.renderer.render(partial: 'game_events/game_event', locals: { text: Game.random_rule })
    ActionCable.server.broadcast "game_channel:#{@game.id}", event_type: :new_rule, content: rendered_game_event
  end
end
