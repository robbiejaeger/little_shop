require 'rails_helper'

RSpec.describe DonationItem, type: :model do
  it {should belong_to(:donation)}
  it {should belong_to(:need_item)}


  xit "outputs supply name of donation_item" do
    nationality = Nationality.create(photo_path: "x",
      info_link: "x",
      greeting: "x",
      name: "Somali")
    family1 = Family.create(first_name: "TestFirst",
      last_name: "TestLast",
      arrival_date: 10.days.from_now,
      donation_deadline: 5.days.from_now,
      nationality_id: nationality.id,
      num_married_adults: 2,
      num_unmarried_adults: 1,
      num_children_over_two: 0,
      num_children_under_two: 0)
    Supply.create(name: "Full Bedframe",
      value: 50.0,
      description: "New or used.  Used must be in good condition.",
      multiplier_type: "adult" )
    family1.create_supply_items
    user1 = User.create(username: "user1", password: "password", email: "email@example.com")
    donation1 = Donation.create(status: 'pledged', user: user1)
    donation_item1 = DonationItem.create(quantity: 1,
      supply_item: family1.supply_items.first,
      donation: donation1)

    expect(donation_item1.name).to eq("Full Bedframe")
  end

  xit "returns correct item name" do
    user = User.create(username: "TestUser", password: "password", email: "email@example.com")
    supply = Supply.create(name: "Small Pot",
      value: 3.0,
      description: "New or used.",
      multiplier_type: "household")

    nationality = Nationality.create(photo_path: "x",
      info_link: "x",
      greeting: "x",
      name: "Somali")

    family = Family.create(first_name: "TestFirst",
      last_name: "TestLast",
      arrival_date: 10.days.from_now,
      donation_deadline: 5.days.from_now,
      nationality: nationality,
      num_married_adults: 2,
      num_unmarried_adults: 1,
      num_children_over_two: 0,
      num_children_under_two: 0)

    supply_item = SupplyItem.create(supply: supply, quantity: 3, family: family)

    donation = Donation.create(status: 'Pledged', user: user)
    donation_item = DonationItem.create(quantity: 2,
      supply_item: supply_item,
      donation: donation)

    expect(donation_item.name).to eq("Small Pot")
  end

  xit "returns correct item value" do
    user = User.create(username: "TestUser", password: "password", email: "email@example.com")
    supply = Supply.create(name: "Small Pot",
      value: 3.0,
      description: "New or used.",
      multiplier_type: "household")

    nationality = Nationality.create(photo_path: "x",
      info_link: "x",
      greeting: "x",
      name: "Somali")

    family = Family.create(first_name: "TestFirst",
      last_name: "TestLast",
      arrival_date: 10.days.from_now,
      donation_deadline: 5.days.from_now,
      nationality: nationality,
      num_married_adults: 2,
      num_unmarried_adults: 1,
      num_children_over_two: 0,
      num_children_under_two: 0)

    supply_item = SupplyItem.create(supply: supply, quantity: 3, family: family)

    donation = Donation.create(status: 'Pledged', user: user)
    donation_item = DonationItem.create(quantity: 2,
      supply_item: supply_item,
      donation: donation)

    expect(donation_item.value).to eq(3.0)
  end

  xit "returns correct item subtotal" do
    user = User.create(username: "TestUser", password: "password", email: "email@example.com")
    supply = Supply.create(name: "Small Pot",
      value: 3.0,
      description: "New or used.",
      multiplier_type: "household")

      nationality = Nationality.create(photo_path: "x",
        info_link: "x",
        greeting: "x",
        name: "Somali")

    family = Family.create(first_name: "TestFirst",
      last_name: "TestLast",
      arrival_date: 10.days.from_now,
      donation_deadline: 5.days.from_now,
      nationality: nationality,
      num_married_adults: 2,
      num_unmarried_adults: 1,
      num_children_over_two: 0,
      num_children_under_two: 0)

    supply_item = SupplyItem.create(supply: supply, quantity: 3, family: family)

    donation = Donation.create(status: 'Pledged', user: user)
    donation_item = DonationItem.create(quantity: 2,
      supply_item: supply_item,
      donation: donation)

    expect(donation_item.subtotal).to eq(6.0)
  end
end
