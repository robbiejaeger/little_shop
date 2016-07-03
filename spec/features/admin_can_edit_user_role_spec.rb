require 'rails_helper'

RSpec.feature "admin can edit user role" do
  scenario "admin changes user role" do
    role = Role.create(name: 'platform_admin')
    role2 = Role.create(name: "business_admin")
    role3= Role.create(name: "business_owner")
    role4= Role.create(name: "registered_user")
    admin, user = create_list(:user, 2)
    charity1, charity2 = create_list(:charity, 2)
    admin_role = UserRole.create(role_id: role.id, user_id: admin.id)
    user_role = UserRole.create(role_id: role4.id, user_id: user.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    click_on "Manage Users"

    click_on "#{user.username}"

    expect(current_path).to eq(admin_user_path(User.find_by(username: "#{user.username}")))
    expect(page).to have_content("All Roles")

    expect(page).to have_content("registered_user")
    expect(user.user_roles.count).to eq(1)

    click_on "Add New Role"

    expect(current_path).to eq(new_admin_user_user_role_path(User.find_by(username: "#{user.username}")))

    select "#{charity2.name}", from: "user_role[charity_id]"
    select "#{role3.name}", from: "user_role[role_id]"

    click_on "Add User Role"

    expect(current_path).to eq(admin_user_path(User.find_by(username: user.username)))
    expect(page).to have_content("business_owner")
    expect(user.user_roles.count).to eq(2)
  end
end
