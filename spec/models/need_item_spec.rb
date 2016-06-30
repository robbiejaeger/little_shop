require 'rails_helper'

RSpec.describe NeedItem, type: :model do
   it { should belong_to(:need) }
   it { should belong_to(:recipient) }
   it { should have_many(:donation_items) }

  #  scenario "check if retired item is retired" do
  #    item = NeedItem.create(quantity: 3,
  #                           deadline:  "Wed, 20 Jun 2016")
   #
  #   expect(item.retired).to eq(item)
  #  end
   #
  #  scenario "check if active item is active" do
  #    item = NeedItem.create(quantity: 3,
  #                           deadline:  "Wed, 20 Jul 2016")
   #
  #   expect(item.active).to eq(item)
  #  end
end
