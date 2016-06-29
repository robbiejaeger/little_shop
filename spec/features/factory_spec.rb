require 'rails_helper'

RSpec.feature  "testing factories" do
  scenario "test it makes a cause" do
    cause = create(:cause)
    expect(cause.name).to eq("Cause-1")
    expect(Cause.count).to eq(1)
  end

  scenario "test it makes a charity" do
    charity_one, charity_two, charity_three = create_list(:charity, 3)
    expect(charity_two.name).to eq("Charity-2")
    expect(charity_two.description).to eq("This is description for Charity-2")
    expect(Charity.count).to eq(3)
  end

  scenario "test it makes a needs_category" do
    needs_category = create(:needs_category)
    expect(needs_category.name).to eq("Needs-Category-1")
    expect(NeedsCategory.count).to eq(1)
  end

  scenario "test it makes a need" do
    need_one, need_two = create_list(:need, 2)
    expect(need_one.name).to eq("Need-1")
    expect(need_one.description).to eq("This is description for Need-1")
    expect(need_one.needs_category).to be_a_kind_of(NeedsCategory)
    expect(need_two.needs_category).to be_a_kind_of(NeedsCategory)
    expect(need_one.price).to eq(10.0)
    expect(need_two.price).to eq(20.0)
    expect(Need.count).to eq(2)
  end

  scenario "test it makes a user" do
    user_one, user_two = create_list(:user, 2)
    expect(user_one.username).to eq("user1")
    expect(user_two.username).to eq("user2")
    expect(user_one.password).to eq("password")
    expect(user_one.email).to eq("fake@fake.com")
  end

  scenario "test it makes a recipient" do
    recipient_one, recipient_two = create_list(:recipient, 2)
    expect(recipient_one.name).to eq("Recipient-1")
    expect(recipient_one.description).to eq("This is description for Recipient-1")
    expect(recipient_one.charity).to be_a_kind_of(Charity)
    expect(Recipient.count).to eq(2)
  end

  scenario "test it makes a future need item" do
    item = create(:future_need_item)
    expect(item.quantity).to eq(1)
    expect(item.need).to be_a_kind_of(Need)
    expect(item.recipient).to be_a_kind_of(Recipient)
    expect(item.deadline).to be > Date.today
    expect(NeedItem.count).to eq(1)
  end

  scenario "test it makes a past need item" do
    item = create(:past_need_item)
    expect(item.quantity).to eq(1)
    expect(item.need).to be_a_kind_of(Need)
    expect(item.recipient).to be_a_kind_of(Recipient)
    expect(item.deadline).to be < Date.today
    expect(NeedItem.count).to eq(1)
  end

  scenario "test it a donation" do
    donation = create(:donation)
    expect(donation.user).to be_a_kind_of(User)
    expect(Donation.count).to eq(1)
  end



end
