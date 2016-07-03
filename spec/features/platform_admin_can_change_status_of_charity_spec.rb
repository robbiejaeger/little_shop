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
save_and_open_page
    click_on "Activate"
    expect(Charity.find(charity.id).status.name).to eq("Active")

  end


  xscenario "platform admin can deactivate and suspend need for charity through index page" do
    role = Role.create(name: 'platform_admin')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    create_list(:status, 3)
    need1 = charity.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_needs_path(charity.slug)

    within ".#{need1.name}" do
      expect(page).to have_link("Suspend")
      click_on "Deactivate"
    end

    expect(current_path).to eq(admin_charity_need_path(charity.slug, need1))

    visit admin_charity_needs_path(charity.slug)

    within ".#{need1.name}" do

      expect(page).to have_link("Activate")
      expect(Need.first.status_id).to eq(2)
      click_on("Suspend")
    end

    visit admin_charity_needs_path(charity.slug)

    within ".#{need1.name}" do
      expect(Need.first.status_id).to eq(3)
      expect(page).to_not have_link("Suspend")
      click_on("Activate")
    end

    expect(Need.first.status_id).to eq(1)

  end


  xscenario "business admin can change status to activated and deactivated but not suspended through show" do

    role = Role.create(name: 'business_admin')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    create_list(:status, 3)
    need1 = charity.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_need_path(charity.slug, need1)

    expect(page).to_not have_link("Suspend")

    click_on "Deactivate"
    expect(Need.first.status_id).to eq(2)
    expect(page).to_not have_link("Suspend")

    click_on "Activate"
    expect(page).to have_link("Deactivate")
    expect(Need.first.status_id).to eq(1)


  end


  xscenario "platform admin can deactivate and suspend need for charity through show page" do
    role = Role.create(name: 'platform_admin')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    create_list(:status, 3)
    need1 = charity.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )


    visit admin_charity_need_path(charity.slug, need1)

    expect(page).to have_link("Suspend")
    click_on "Deactivate"
    expect(Need.first.status_id).to eq(2)
    click_on "Suspend"
    expect(Need.first.status_id).to eq(3)
    click_on "Activate"
    expect(Need.first.status_id).to eq(1)
    expect(page).to have_link("Suspend")
    expect(page).to have_link("Deactivate")

  end

end
