class DocsRemoveChannel < ApplicationCable::Channel
  def self.broadcast(doc)
    broadcast_to 'docs_remove_channel', doc_id: "#doc_#{doc.id}"
  end

  def subscribed
    # stream_from "some_channel"
    stream_for 'docs_remove_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
