# frozen_string_literal: true

require 'rails_helper'

describe 'User::Say', js: true do
  subject { page }

  let!(:user) { create :user }

  before do
    sign_in user
  end

  scenario 'Write a message' do
    click_link 'Messenger'
    fill_in 'body', with: 'Hello!'
    click_button 'Send'
    within '#message_list' do
      is_expected.to have_content 'Hello!'
    end
  end
end
