require 'rails_helper'

RSpec.feature "user can update item in cart" do
  scenario "items is updated" do
    item = create(:future_need_item_multiple)
    recipient = item.recipient
    charity = recipient.charity

    visit charity_recipient_path(charity.slug, recipient)

    within(".#{item.name}") do
      select  5, from: "need_item[quantity]"
      find(:button, "add to cart").click
    end

    visit cart_index_path

    expect(page).to have_content("Total: $#{item.price * 5}0")

    expect(page).to have_content("#{item.name}")

    select  2, from: "need_item[quantity]"
    click_on("Update Cart")

    expect(page).to have_content("Total: $#{item.price * 2}0")
  end
end
