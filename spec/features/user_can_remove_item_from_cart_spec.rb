
require 'rails_helper'

RSpec.feature "user can remove item from cart" do
  scenario "items is removed" do

    item = create(:future_need_item)
    recipient = item.recipient
    charity = recipient.charity

    visit charity_recipient_path(charity.slug, recipient)

    within(".#{item.name}") do
      select  1, from: "need_item[quantity]"
      find(:button, "add to cart").click
    end

    visit cart_index_path
    expect(page).to have_content("Total: $#{item.price}0")

    expect(page).to have_content("#{item.name}")
    click_on("Remove")

    expect(page).to have_content("Successfully deleted #{item.name}")
    expect(page).to have_content("There are no items in your cart")
  end

end
