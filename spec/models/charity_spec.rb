require 'rails_helper'

RSpec.describe Charity, type: :model do
   it { should validate_presence_of(:name) }
   it { should validate_presence_of(:description) }
   it { should have_many(:causes_charities) }
   it { should have_many(:causes) }
   it { should have_many(:recipients) }

   scenario "creating a slug method" do
     charity = create(:charity)

     expect(charity.slug).to eq("#{charity.name}".parameterize)
   end

   scenario "see if recipient belongs a charity" do
     recipient_one = create(:recipient)
     recipient_two = create(:recipient)
     charity_one = recipient_one.charity
     charity_two = recipient_two.charity

     expect(charity_one.associated_recipient?(recipient_one.id)).to eq(true)
     expect(charity_one.associated_recipient?(recipient_two.id)).to eq(false)
   end

end
