require 'rails_helper'

RSpec.feature "admin can change status for charity" do
  scenario "platform admin can change status to activated and suspended" do

    role = Role.create(name: 'platform_admin')
    user = create(:user)
    user_role = UserRole.create(role_id: role.id, user_id: user.id)
    Status.create(name: 'Active')
    Status.create(name: 'Inactive')
    Status.create(name: 'Suspended')
    charity = create(:inactive_charity)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    expect(charity.status.name).to eq("Inactive")
    visit admin_dashboard_path

    within(".to-approve") do
      expect(page).to have_content(charity.name)
      click_on "View"
    end

    expect(current_path).to eq(admin_charity_dashboard_path(charity.slug))

    expect(page).to have_link("Suspend")
    expect(page).to have_link("Activate")

    click_on "Activate"

    expect(current_path).to eq(admin_dashboard_path)

    within(".to-approve") do
      expect(page).to_not have_content(charity.name)
    end

    expect(Charity.find(charity.id).status.name).to eq("Active")

    within(".active-charities") do
      expect(page).to have_content(charity.name)
      click_on "View"
    end

    click_on "Suspend"
    expect(Charity.find(charity.id).status.name).to eq("Suspended")

    within(".active-charities") do
      expect(page).to_not have_content(charity.name)
    end

    within(".suspended-charities") do
      expect(page).to have_content(charity.name)
      click_on "View"
    end

    click_on "Activate"
    expect(Charity.find(charity.id).status.name).to eq("Active")

  end


  scenario "business admin can deactivate and activate, but not suspend charity" do

    Status.create(name: 'Active')
    Status.create(name: 'Inactive')
    Status.create(name: 'Suspended')
    role = Role.create(name: 'business_admin')
    user = create(:user)
    charity = create(:inactive_charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    expect(charity.status.name).to eq("Inactive")
    visit admin_charity_dashboard_path(charity.slug)

    expect(page).to_not have_link("Suspend")
    expect(page).to have_link("Activate")

    click_on "Activate"

    expect(Charity.find(charity.id).status.name).to eq("Active")

    expect(current_path).to eq(admin_charity_dashboard_path(charity.slug))

    expect(page).to_not have_link("Suspend")
    expect(page).to have_link("Deactivate")

    click_on "Deactivate"

    expect(Charity.find(charity.id).status.name).to eq("Inactive")

  end

  scenario "business owner can deactivate and activate, but not suspend charity" do

    Status.create(name: 'Active')
    Status.create(name: 'Inactive')
    Status.create(name: 'Suspended')
    role = Role.create(name: 'business_owner')
    user = create(:user)
    charity = create(:inactive_charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    expect(charity.status.name).to eq("Inactive")
    visit admin_charity_dashboard_path(charity.slug)

    expect(page).to_not have_link("Suspend")
    expect(page).to have_link("Activate")

    click_on "Activate"

    expect(Charity.find(charity.id).status.name).to eq("Active")

    expect(current_path).to eq(admin_charity_dashboard_path(charity.slug))

    expect(page).to_not have_link("Suspend")
    expect(page).to have_link("Deactivate")

    click_on "Deactivate"

    expect(Charity.find(charity.id).status.name).to eq("Inactive")

  end

end
