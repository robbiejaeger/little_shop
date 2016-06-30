require 'rails_helper'

RSpec.feature "user sees past donation" do
  scenario "donation page is shown for authenticated user" do
    donation, other_users_donation = create_list(:donation, 2)
    user = User.find(donation.user_id)
    other_user = User.find(other_users_donation.user_id)
    need_item = NeedItem.create(quantity: 5, recipient_id: 1, deadline: Time.now, need_id: 1)

    visit login_path

    fill_in "Username", with: "#{user.username}"
    fill_in "Password", with: "password"
    click_on "Login to Account"

    visit donations_path
    click_on(donation.id)
    expect(current_path).to eq(donation_path(donation))

    expect(page).to have_content("Donation #{donation.id}")
  end
end
