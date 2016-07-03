require 'rails_helper'

RSpec.feature "admin can add need items for recipients" do
  scenario "need items added to recipient" do
    role = Role.create(name: "business_admin")
    user = create(:user)
    charity = create(:charity)
    status = create(:status)
    user_role = UserRole.create(role_id: role.id,
                                user_id: user.id,
                                charity_id: charity.id)
    need = charity.needs.create(name: "Need-1",
                                description: "description for Need-1",
                                price: 10,
                                needs_category: create(:needs_category))
    recipient = Recipient.create(name: "Recipient",
                                 description: "Recipient description",
                                charity_id: charity.id)
    # need_item = NeedItem.create(need_id: need.id , recipient_id: recipient.id,
    #                             quantity: 2,  deadline: "2016-07-24 00:00:00" )
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_recipients_path(charity.slug)

    within ".#{recipient.name}" do
      click_on "View Details"
    end

    expect(current_path).to eq(admin_charity_recipient_path(charity.slug, recipient))

    expect(page).to have_content(recipient.name)
# save_and_open_page

    expect(page).to have_content("Recipient Needs")
    expect(page).to have_content("Quantity")
    expect(page).to have_content("Deadline")

    click_on "Add Need for this Recipient"

    expect(current_path).to eq(new_admin_charity_recipient_need_item_path(charity.slug, recipient))
    select "#{need.name}", from: "charity[need_id]"
    fill_in "Quantity", with: 5
    select '2016/07/20', :from => 'Date Needed By'

  end

end
