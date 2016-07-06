require 'rails_helper'

RSpec.feature "user can login and logout" do
  scenario "they can login and see their dashboard" do

    user = User.create(username: "Robbie", password: "password", email: "test@example.com")

    visit login_path

    fill_in "Username", with: "Robbie"
    fill_in "Password", with: "password"
    click_on "Login to Account"

    expect(page).to have_content "Dashboard"
    expect(page).to have_content "Logged in as Robbie"
    expect(page).to have_content "Logout"
    expect(page).to_not have_content "Login"
  end

  scenario "they logout and see the home page" do
    user = User.create(username: "Robbie", password: "password", email: "test@example.com")

    visit login_path

    fill_in "Username", with: "Robbie"
    fill_in "Password", with: "password"
    click_on "Login to Account"

    click_on "Logout"

    expect(page).to have_content "Login"
    expect(page).to_not have_content "Logout"
    expect(page).to_not have_content "Logged in as Robbie"
  end
end
