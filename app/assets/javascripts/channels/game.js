var subscribeToGameChannel = function(game_id) {
  let game_chanel = 'game_' + game_id

  if (App[game_chanel] != null) {
    console.log("Already subscribed");
    return App[game_chanel];
  } else {
    console.log("Subscribing ...");

    App[game_chanel] = App.cable.subscriptions.create({ channel: 'GameChannel', game: game_id }, {
      connected: function() {
        // Called when the subscription is ready for use on the server
      },

      disconnected: function() {
        // Called when the subscription has been terminated by the server
      },

      received: function(data) {
        // Called when there's incoming data on the websocket for this channel
        this.renderGameEvent(data);
      },

      renderGameEvent: function(data) {
        $('.game[data-game-id="' + game_id +'"] #events').append(data['content']);
      }
    });

    return App[game_chanel];
  }
}

var initSupporterBar = function(channel) {
  $('.reactor').on('click', function(e) {
    e.preventDefault();
    channel.send({ reaction: $(this).text() })
  });
}

$(document).on('turbolinks:load', function() {
  let game_id = $('.game').data('game-id')

  if (game_id != null) {
    const gameChannel = subscribeToGameChannel(game_id);
    initSupporterBar(gameChannel);
  }
});
