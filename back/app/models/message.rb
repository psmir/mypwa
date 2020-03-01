# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :user, inverse_of: :messages
  belongs_to :addressee, class_name: 'User', inverse_of: :messages, optional: true

  scope :general, -> { where(addressee_id: nil) }
  scope :newer, -> { order(created_at: :desc) }
  scope :latest, ->(n) { newer.limit(n) }
  scope :between, ->(id1, id2) do
    where(
      'user_id=:id1 AND addressee_id=:id2 OR addressee_id=:id1 AND user_id=:id2',
      id1: id1, id2: id2
    )
  end
end
