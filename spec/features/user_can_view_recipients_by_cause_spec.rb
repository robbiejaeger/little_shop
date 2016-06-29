require 'rails_helper'

RSpec.feature "User Can View the Recipients by Cause" do
  scenario "user navigates to recipients from cause" do
  recipient = create(:recipient)
  cause = create(:cause)
  recipient.charity.causes << cause

  visit root_path
  click_on "Cause-1"
  expect(current_path).to eq(cause_path(cause.slug))

  expect(page).to have_content(recipient.name)
  expect(page).to have_content(recipient.description)

  click_on "#{recipient.name}"
  expect(current_path).to eq(charity_recipient_path(recipient.charity.slug, recipient))
  end
end
