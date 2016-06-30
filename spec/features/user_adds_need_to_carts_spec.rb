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


  scenario "cart has need that user added for multiple charities recipients" do

    charity_one, charity_two = create_list(:charity, 2)
    recipient_one, recipient_two = create_list(:recipient, 2)
    recipient_one.charity = charity_one
    recipient_two.charity = charity_two
    recipient_one.need_items.create(quantity: 2, need: create(:need), deadline: 5.days.from_now)
    recipient_two.need_items.create(quantity: 8, need: create(:need), deadline: 5.days.from_now)

    visit charity_recipient_path(charity_one.slug, recipient_one)

    within(".#{recipient_one.need_items.first.name}") do
      select  1, from: "need_item[quantity]"
      find(:button, "add to cart").click
    end

    visit charity_recipient_path(charity_two.slug, recipient_two)

    within(".#{recipient_two.need_items.first.name}") do
      select  1, from: "need_item[quantity]"
      find(:button, "add to cart").click
    end

    visit cart_index_path

    expect(page).to have_content("#{recipient_one.need_items.first.name}")
    expect(page).to have_content("#{recipient_two.need_items.first.name}")

    #the charity names are wrong...
    click_on "#{recipient_one.charity.name}"

    expect(current_path).to eq(charity_path(recipient_one.charity.slug))
  end
end
