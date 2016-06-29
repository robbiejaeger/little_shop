require 'rails_helper'

RSpec.feature "user can see all donations they have made" do
  scenario "authenticated user sees list of only her donations when she has one previous donation" do
    donation, other_users_donation = create_list(:donation, 2)
    user = User.find(donation.user_id)
    other_user = User.find(other_users_donation.user_id)
    visit login_path

    fill_in "Username", with: "#{user.username}"
    fill_in "Password", with: "password"
    click_on "Login to Account"

    visit donations_path
    expect(page).to have_content("#{user.username}'s Donations")
    expect(page).to have_content("Total Donations: 1")
    expect(page).to have_link("#{donation.id}", href: "/donations/#{donation.id}")
    expect(page).to_not have_link("#{other_users_donation.id}", href: "/donations/#{other_users_donation.id}")
  end

  scenario "guest user visiting donations is redirected to log in" do
    visit donations_path

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Please login to see your donation history")
  end
end
