require 'rails_helper'

RSpec.feature "User Can View the Recipients by Charity" do
  scenario "user navigates to recipients from root" do

  recipient_one = create(:future_need_item).recipient

  visit root_path

  click_on "Charities"

  expect(current_path).to eq(charities_path)

  expect(page).to have_content("All Charities")

  click_on "#{recipient_one.charity.name}"

  expect(current_path).to eq(charity_path(recipient_one.charity.slug))

  expect(page).to have_content(recipient_one.name)
  expect(page).to have_content(recipient_one.description)

  click_on "#{recipient_one.name}"
  expect(current_path).to eq(charity_recipient_path(recipient_one.charity.slug, recipient_one))
  end

end
