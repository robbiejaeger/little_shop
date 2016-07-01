require 'rails_helper'

RSpec.feature "admin can see individual need for charity" do
  scenario "business admin can see need" do

    role = Role.create(name: 'business_admin')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)

    need1 = charity.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_needs_path(charity.slug)
    within ".#{need1.name}" do
      click_on "View Details"
    end

    expect(current_path).to eq(admin_charity_need_path(charity.slug, need1))

    expect(page).to have_content("#{need1.name}")
    expect(page).to have_content("#{need1.description}")
    expect(page).to have_content("#{need1.price}")
    expect(page).to have_content("#{need1.needs_category.name}")

  end

  scenario "business owner can a need" do

    role = Role.create(name: 'business_owner')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)

    need1 = charity.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_needs_path(charity.slug)
    within ".#{need1.name}" do
      click_on "View Details"
    end

    expect(current_path).to eq(admin_charity_need_path(charity.slug, need1))

    expect(page).to have_content("#{need1.name}")
    expect(page).to have_content("#{need1.description}")
    expect(page).to have_content("#{need1.price}")
    expect(page).to have_content("#{need1.needs_category.name}")

  end

  scenario "business owner cannot see need of other charity" do

    role = Role.create(name: 'business_owner')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    charity_two = create(:charity)

    need1 = charity_two.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_need_path(charity_two, need1)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("not authorized")

  end

  scenario "business admin cannot see needs of other charity" do

    role = Role.create(name: 'business_admin')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    charity_two = create(:charity)

    need1 = charity_two.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_need_path(charity_two, need1)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("not authorized")

  end

  scenario "platform admin can see needs of any charity" do

    role = Role.create(name: 'platform_admin')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id)

    need1 = charity.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_needs_path(charity.slug)

    within ".#{need1.name}" do
      click_on "View Details"
    end

    expect(current_path).to eq(admin_charity_need_path(charity.slug, need1))

    expect(page).to have_content("#{need1.name}")

  end


  scenario "reg user cannot see charity needs" do

    role = Role.create(name: 'registered_user')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity: charity)
    need1 = charity.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_need_path(charity.slug, need1)

    expect(page).to have_content("not authorized")
    expect(current_path).to eq(root_path)

  end
end
