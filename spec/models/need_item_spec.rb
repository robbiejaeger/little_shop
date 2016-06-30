require 'rails_helper'

RSpec.describe NeedItem, type: :model do
   it { should belong_to(:need) }
   it { should belong_to(:recipient) }
   it { should have_many(:donation_items) }

   it "#name returns need name" do
     need_item = create(:future_need_item)

     expect(need_item.name).to eq(need_item.name)
   end

   it "#description returns need description" do
     need_item = create(:future_need_item)

     expect(need_item.description).to eq(need_item.description)
   end

   it "#price returns need price" do
     need_item = create(:future_need_item)

     expect(need_item.price).to eq(need_item.price)
   end

   it "#charity returns recipient's charity" do
     need_item = create(:future_need_item)

     expect(need_item.charity).to eq(need_item.recipient.charity)
   end

   it "#quantity_remaning returns recipient's remaining need quantity" do
     donation_item = create(:donation_item)
     need_item = donation_item.need_item

     expect(need_item.quantity_remaining).to eq(0)
   end

   it "#subtotal returns subtotal of need_item" do
       need_item = create(:future_need_item)

       expect(need_item.subtotal(2).to_int).to eq(60)
   end

end
