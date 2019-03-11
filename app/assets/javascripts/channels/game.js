var gameChannelFor = function(game_id) {
  var game_channel = 'game_' + game_id

  if (App[game_channel] != null) {
    return App[game_channel];
  } else {
    App[game_channel] = App.cable.subscriptions.create({ channel: 'GameChannel', game: game_id }, {
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
        if(data['event_type'] == "reaction") {
          $('.game[data-game-id="' + game_id +'"] .event-reactions').last().append(data['content']);
        } else {
          $('.game[data-game-id="' + game_id +'"] #events').append(data['content']);
        }

        $('html, body').animate({scrollTop: $(document).height()});
      }
    });

    return App[game_channel];
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
  var game_id = $('.game').data('game-id')

  if (game_id != null) {
    const channel = gameChannelFor(game_id);
    initSupporterBar(channel);
    initBallSelector(channel);
    initPlayerSelector(channel);
  }
});
