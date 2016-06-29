require 'rails_helper'

RSpec.feature "User Adds Need To Carts" do
  scenario "cart has need that user added for one charities recipient" do

    item = create(:future_need_item)
    recipient = item.recipient
    charity = recipient.charity

    visit charity_recipient_path(charity.slug, recipient)

    within(".#{item.name}") do
      select  1, from: "need_item[quantity]"
      find(:button, "add to cart").click
    end

    visit cart_index_path

    expect(page).to have_content("#{item.name}")
  end
end
