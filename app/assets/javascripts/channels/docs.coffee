App.docs = App.cable.subscriptions.create "DocsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#docs table').prepend data.doc
