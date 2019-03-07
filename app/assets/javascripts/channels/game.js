var gameChannelFor = function(game_id) {
  let game_chanel = 'game_' + game_id

  if (App[game_chanel] != null) {
    return App[game_chanel];
  } else {
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
    // channel.send({ reaction: $(this).text() })
    channel.perform('reaction', { reaction: $(this).text() });
  });
}

var initBallSelector = function(channel) {
  $('.ball').on('click', function(e) {
    e.preventDefault();
    channel.perform('ball_in_the_pocket', { ball_number: $(this).text() });
    $(this).hide();
  });
}

var initPlayerSelector = function(channel) {
  $('input[name="current_player"]').on('change', function(e) {
    var $checked = $('input[name="current_player"]').filter(function() {
      return $(this).prop('checked');
    });

    channel.perform('new_turn', { player: $checked.val() });
  });
}

$(document).on('turbolinks:load', function() {
  let game_id = $('.game').data('game-id')

  if (game_id != null) {
    const channel = gameChannelFor(game_id);
    initSupporterBar(channel);
    initBallSelector(channel);
    initPlayerSelector(channel);
  }
});
