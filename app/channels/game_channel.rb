class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_channel:#{params[:game]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed

    Rails.logger.debug "unsubscribed"
  end
end
