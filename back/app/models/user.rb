# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  enum role: %i[user admin]

  has_many :messages, inverse_of: :user
  has_many :incoming_messages, class_name: 'Message', foreign_key: :addressee_id, inverse_of: :addressee

  def set_online!
    update(online: true)
  end

  def set_offline!
    update(online: false)
  end
end
