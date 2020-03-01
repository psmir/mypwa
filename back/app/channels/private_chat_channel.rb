# frozen_string_literal: true

class PrivateChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "PrivateChatChannel_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
