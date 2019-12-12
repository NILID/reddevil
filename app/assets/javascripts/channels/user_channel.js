$(function() {
  App.cable.subscriptions.create({channel: "UserChannel"}, {
    received: function(data) {
      $('.user-online-counter').text(data);
    }
  });
});
