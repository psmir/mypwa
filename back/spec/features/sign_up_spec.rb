# frozen_string_literal: true

require 'rails_helper'

describe 'Login' do
  let(:email) { 'some@email.com' }
  let(:password) { 'password' }

  scenario 'user can sign up', js: true do
    visit '/'
    click_link 'Sign Up'
    fill_in 'email', with: email
    fill_in 'password', with: password
    fill_in 'password-confirmation', with: password
    click_button 'Sign Up'
    expect(page).to have_link 'Logout'
    expect(page).to have_content email
  end
end
