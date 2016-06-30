require 'rails_helper'

RSpec.feature "admin can see all needs for charity" do
  scenario "admin can see all needs" do

    admin_user = create(:business_admin_user)
    charity = admin_user.charity
    need1 = charity.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))
    need2 = charity.needs.create(name: "Need-2", description: "description for Need-2", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( admin_user )

    visit admin_dashboard_path
    click_on "Manage Needs"
    expect(current_path).to eq(admin_needs_path)
    expect(page).to have_content("#{need1.name}")
    expect(page).to have_content("#{need2.name}")

  end
end
