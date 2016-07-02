require 'rails_helper'

RSpec.feature "admin can add recipient for charity" do
  scenario "business admin can add recipient" do
    role = Role.create(name: 'business_admin')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    expect(charity.recipients.count).to eq(0)
    visit admin_charity_recipients_path(charity.slug)
    click_on "Add Recipient"

    expect(current_path).to eq(new_admin_charity_recipient_path(charity.slug))
    fill_in "Name", with: "Recipient-1"
    fill_in "Description", with: "description"
    click_on "Create Recipient"
    expect(current_path).to eq(admin_charity_recipient_path(charity.slug, charity.recipients.first))
    expect(page).to have_content("Recipient-1")
    expect(page).to have_content("description")
    expect(charity.recipients.count).to eq(1)
  end
end
