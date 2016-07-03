require 'rails_helper'

RSpec.feature "user can create an inactive charity for approval and is assigned business owner role" do
  scenario "business admin can add recipient" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit root_path
    click_on "Add Your Charity"

    expect(current_path).to eq(new_charity_path)
    fill_in "Name", with: "New Charity"
    fill_in "Description", with: "New Charity Description"
    click_on "Submit Charity"

    expect(current_path).to eq(dashboard_path)
    charity = Charity.find_by(name: "New Charity")

    expect(page).to have_content(charity.name)
    expect(page).to have_content("business_owner")
    click_on charity.name
    expect(current_path).to eq(admin_charity_dashboard(charity.slug))
    expect(page).to have_content("Inactive")

  end

  scenario "inactive charity is not available to user" do

    role = Role.create(name: 'business_owner')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_recipients_path(charity.slug)


    click_on "Add Recipient"

    expect(current_path).to eq(new_admin_charity_recipient_path(charity.slug))

    fill_in "Name", with: "Recipient"
    fill_in "Description", with: "Description for Recipient"
    click_on "Create Recipient"

    expect(current_path).to eq(admin_charity_recipient_path(charity.slug, charity.recipients.first))

    expect(page).to have_content("Recipient")
    expect(page).to have_content("Description for Recipient")
  end

  scenario "business owner cannot create recipient for other charity" do
    role = Role.create(name: 'business_owner')
    user = create(:user)
    charity_one, charity_two = create_list(:charity, 2)

    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity_one.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit new_admin_charity_recipient_path(charity_two.slug)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("not authorized")
  end

  scenario "business admin cannot create recipient for other charity" do
    role = Role.create(name: 'business_admin')
    user = create(:user)
    charity_one, charity_two = create_list(:charity, 2)

    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity_one.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit new_admin_charity_recipient_path(charity_two.slug)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("not authorized")
  end

  scenario "platform admin can create recipient for charity" do

    role = Role.create(name: 'platform_admin')
    user = create(:user)
    charity = create(:charity)

    user_role = UserRole.create(role_id: role.id, user_id: user.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_recipients_path(charity.slug)

    click_on "Add Recipient"

    expect(current_path).to eq(new_admin_charity_recipient_path(charity.slug))

    fill_in "Name", with: "Recipient"
    fill_in "Description", with: "Description for Recipient"
    click_on "Create Recipient"

    expect(current_path).to eq(admin_charity_recipient_path(charity.slug, charity.recipients.first))

    expect(page).to have_content("Recipient")
    expect(page).to have_content("Description for Recipient")
  end

  scenario "registered user cannot create recipient" do

    role = Role.create(name: 'registered_user')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity: charity)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit new_admin_charity_recipient_path(charity.slug)

    expect(page).to have_content("not authorized")
    expect(current_path).to eq(root_path)
  end

end
