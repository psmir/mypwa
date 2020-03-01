# frozen_string_literal: true

require 'rails_helper'

describe Message::Latest do
  let!(:current_user) { create :user }
  let!(:some_user) { create :user }
  let(:user_id) { nil }

  let!(:message1) { create :message }
  let!(:message2) { create :message, user_id: current_user.id, addressee_id: some_user.id }
  let!(:message3) { create :message, user_id: some_user.id, addressee_id: current_user.id }

  subject { Message::Latest.run({ user_id: user_id }, actor: current_user) }

  it 'returns general messages' do
    is_expected.to be_success
    expect(subject.result).to eq [
      { id: message1.id, author: message1.user.email, body: message1.body }
    ]
  end

  context 'user_id aka room is provided' do
    let(:user_id) { some_user.id }

    it 'returns personal messages' do
      is_expected.to be_success
      expect(subject.result).to match [
        { id: message2.id, author: message2.user.email, body: message2.body },
        { id: message3.id, author: message3.user.email, body: message3.body }
      ]
    end
  end
end
