require 'rails_helper'

RSpec.feature "admin can add need for charity" do
  scenario "business admin can add need" do

    role = Role.create(name: 'business_admin')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    need_cat1, need_cat2 = create_list(:needs_category, 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_needs_path(charity)

    click_on "Add Need"

    expect(current_path).to eq(new_admin_charity_need_path(charity))

    fill_in "Name", with: "Need-1"
    fill_in "Description", with: "description for Need-1"
    fill_in "Price", with: 10
    select "#{need_cat1.name}", from: "need[needs_category_id]"
    click_on "Create Need"

    expect(current_path).to eq(admin_charity_need_path(charity, Need.first))

    expect(page).to have_content("Need-1")
    expect(page).to have_content("description for Need-1")
    expect(page).to have_content("10")
    expect(page).to have_content("#{need_cat1.name}")

    expect(need_cat1.needs.first).to eq(Need.first)

  end

  scenario "business owner can a need" do

    role = Role.create(name: 'business_owner')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    need_cat1, need_cat2 = create_list(:needs_category, 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_needs_path(charity)

    click_on "Add Need"

    expect(current_path).to eq(new_admin_charity_need_path(charity))

    fill_in "Name", with: "Need-1"
    fill_in "Description", with: "description for Need-1"
    fill_in "Price", with: 10
    select "#{need_cat1.name}", from: "need[needs_category_id]"
    click_on "Create Need"

    expect(current_path).to eq(admin_charity_need_path(charity, Need.first))

    expect(page).to have_content("Need-1")
    expect(page).to have_content("description for Need-1")
    expect(page).to have_content("10")
    expect(page).to have_content("#{need_cat1.name}")

    expect(need_cat1.needs.first).to eq(Need.first)

  end

  scenario "business owner cannot create need for other charity" do

    role = Role.create(name: 'business_owner')
    user = create(:user)
    charity_one, charity_two = create_list(:charity, 2)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity_one.id)
    need_cat1, need_cat2 = create_list(:needs_category, 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit new_admin_charity_need_path(charity_two)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("not authorized")

  end

  scenario "business admin cannot create need for other charity" do

    role = Role.create(name: 'business_admin')
    user = create(:user)
    charity_one, charity_two = create_list(:charity, 2)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity_one.id)
    need_cat1, need_cat2 = create_list(:needs_category, 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit new_admin_charity_need_path(charity_two)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("not authorized")

  end

  scenario "platform admin can create need for charity" do

    role = Role.create(name: 'platform_admin')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id)
    need_cat1, need_cat2 = create_list(:needs_category, 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_needs_path(charity)

    click_on "Add Need"

    expect(current_path).to eq(new_admin_charity_need_path(charity))

    fill_in "Name", with: "Need-1"
    fill_in "Description", with: "description for Need-1"
    fill_in "Price", with: 10
    select "#{need_cat1.name}", from: "need[needs_category_id]"
    click_on "Create Need"

    expect(current_path).to eq(admin_charity_need_path(charity, Need.first))

    expect(page).to have_content("Need-1")
    expect(page).to have_content("description for Need-1")
    expect(page).to have_content("10")
    expect(page).to have_content("#{need_cat1.name}")

    expect(need_cat1.needs.first).to eq(Need.first)

  end


  scenario "reg user cannot see charity needs" do

    role = Role.create(name: 'registered_user')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity: charity)
    need1 = charity.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit new_admin_charity_need_path(charity)

    expect(page).to have_content("not authorized")
    expect(current_path).to eq(root_path)

  end
end
