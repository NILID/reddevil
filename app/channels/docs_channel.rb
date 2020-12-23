class DocsChannel < ApplicationCable::Channel
  def self.broadcast(doc)
    broadcast_to 'docs_channel', doc: DocsController.render(partial: 'docs/mini_doc', locals: { mini_doc: doc })
  end

  def subscribed
    # stream_from "some_channel"
    stream_for 'docs_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
