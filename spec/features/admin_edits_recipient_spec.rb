require 'rails_helper'

RSpec.feature "admin can edit recipient for charity" do
  scenario "business admin can edit recipient" do

    role = Role.create(name: 'business_admin')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    recipient = Recipient.create(name: "Recipient", description: "Recipient description", charity_id: charity.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_recipients_path(charity.slug)

    within ".#{recipient.name}" do
      click_on "Update"
    end
    expect(current_path).to eq(edit_admin_charity_recipient_path(charity.slug, recipient))

    fill_in "Name", with: "Recipient-New"
    fill_in "Description", with: "New description for Recipient"
    click_on "Update Recipient"

    expect(current_path).to eq(admin_charity_recipient_path(charity.slug, charity.recipients.first))

    expect(page).to have_content("Recipient-New")
    expect(page).to have_content("New description for Recipient")
  end
end
