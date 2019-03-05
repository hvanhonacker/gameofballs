var subscribeToGameChannel = function(game_id) {
  App['game' + game_id] = App['game' + game_id] || App.cable.subscriptions.create({ channel: 'GameChannel', game: game_id }, {

    connected: function() {
      // Called when the subscription is ready for use on the server
    },

    disconnected: function() {
      // Called when the subscription has been terminated by the server
    },

    received: function(data) {
      // Called when there's incoming data on the websocket for this channel
      console.log(data);
      this.renderEvent(data);
    },

    renderEvent: function(data) {
      $("#events").append(data['content']);
    }
  });
}

$(document).on('turbolinks:load', function() {
  let game_id = $('#game').data('game-id')
  if(game_id != null) {
    subscribeToGameChannel(game_id);
  }
});
