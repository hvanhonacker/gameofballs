App.game = App.cable.subscriptions.create("GameChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log(data);

    let event = document.createElement('li');
    event.innerHTML = data['event_text'];
    event.classList.add('event');
    document.getElementById('events').appendChild(event);
  }
});
