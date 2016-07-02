require 'rails_helper'

RSpec.feature "business owner or admin can create new business admins" do
  scenario "business owner creates new business admin" do
    role4= Role.create(name: "registered_user")
    role = Role.create(name: 'platform_admin')
    role3= Role.create(name: "business_owner")
    role2 = Role.create(name: "business_admin")
    admin, affiliated_admin, new_affiliated_user, unaffiliated_admin = create_list(:user, 4)
    charity1, charity2 = create_list(:charity, 2)
    admin_role = UserRole.create(role_id: role2.id,
                                 user_id: admin.id,
                                 charity_id: charity1.id)
    affiliated_admin_role = UserRole.create(role_id: role2.id,
                                            user_id: affiliated_admin.id,
                                            charity_id: charity1.id)
    new_affiliated_user_role = UserRole.create(role_id: role4.id,
                                user_id: new_affiliated_user.id)
    unaffiliated_admin_role = UserRole.create(role_id: role2.id,
                                              user_id: unaffiliated_admin.id,
                                              charity_id: charity2.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    click_on "Manage Users"

    expect(page).to have_content("Current Users")

    within(".#{charity1.name}") do
      expect(page).to have_content(affiliated_admin.username)
      expect(page).to_not have_content(unaffiliated_admin.username)
    end

    click_on "#{new_affiliated_user.username}"

    expect(current_path).to eq(admin_user_path(User.find_by(username: "#{new_affiliated_user.username}")))

    click_on "Add New Role"
    expect(current_path).to eq(new_admin_user_user_role_path(User.find_by(username: new_affiliated_user.username)))
    expect(page).to have_select("user_role[charity_id]", options: ["#{charity1.name}"])
    expect(page).to_not have_select("user_role[charity_id]", options: ["#{charity1.name}", "#{charity2.name}"])
    expect(page).to have_select("user_role[role_id]", options: ["#{role2.name}", "#{role3.name}"])
    expect(page).to_not have_select("user_role[role_id]", options: ["#{role.name}", "#{role2.name}", "#{role3.name}"])

    select "#{charity1.name}", from: "user_role[charity_id]"
    select "#{role2.name}", from: "user_role[role_id]"
    click_on "Add User Role"
    expect(current_path).to eq(admin_user_path(User.find_by(username: new_affiliated_user.username)))
    
    visit admin_users_path
    within(".#{charity1.name}") do
      expect(page).to have_content(new_affiliated_user.username)
    end
  end


end
