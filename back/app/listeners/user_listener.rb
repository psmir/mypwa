# frozen_string_literal: true

class UserListener < BaseListener
  def user_say_success(result, actor)
    message = {
      id: result[:id],
      user_id: result[:user_id],
      addressee_id: result[:addressee_id],
      author: actor.email,
      body: result[:body],
    }

    channels = []

    if result[:addressee_id].present?
      channels << "PrivateChatChannel_#{result[:addressee_id]}"
      channels << "PrivateChatChannel_#{result[:user_id]}" if result[:user_id] != result[:addressee_id]
    else
      channels << 'ChatChannel'
    end

    channels.each { |channel| ActionCable.server.broadcast(channel, message: message) }
  end

  def user_set_online_success(_result, _actor)
    ActionCable.server.broadcast(
      'UserListChannel',
      users: User.order(:email).select(:id, :email, :online)
    )
  end

  def user_set_offline_success(_result, _actor)
    ActionCable.server.broadcast(
      'UserListChannel',
      users: User.order(:email).select(:id, :email, :online)
    )
  end
end
