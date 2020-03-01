# frozen_string_literal: true

class Message::Latest < BaseOperation
  optional do
    integer :page, default: 1
    integer :user_id
  end

  def authorized?
    actor.present?
  end

  def execute
    messages = Message.newer.page(page).per(20)
    messages = user_id.present? ? messages.between(user_id, actor.id) : messages.general

    messages.reverse.map do |msg|
      { id: msg.id, author: msg.user.email, body: msg.body }
    end
  end
end
