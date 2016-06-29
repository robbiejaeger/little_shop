require 'rails_helper'

RSpec.feature "User Can View the Recipients" do
  scenario "user navigates to recipients from root" do
  recipient_one, recipient_two = create_list(:recipient, 2)

  visit root_path

  click_on "Charities"

  expect(current_path).to eq(charities_path)

  expect(page).to have_content("All Charities")

  click_on "1 Charity"

  expect(current_path).to eq(charity_path(recipient_one.charity))

  expect(page).to have_content(recipient_one.name)
  expect(page).to have_content(recipient_one.description)
  end
end
