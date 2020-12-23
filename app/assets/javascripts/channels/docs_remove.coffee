App.docs = App.cable.subscriptions.create "DocsRemoveChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $(data.doc_id).fadeOut()
