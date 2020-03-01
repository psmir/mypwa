# frozen_string_literal: true

class User::Say < BaseOperation
  required do
    string :body
  end

  optional do
    integer :addressee_id
  end

  def authorized?
    actor.present?
  end

  def execute
    record = actor.messages.create(body: body, addressee_id: addressee_id)

    { id: record.id, user_id: record.user_id, author: actor.email, body: record.body, addressee_id: record.addressee_id }
  end
end
