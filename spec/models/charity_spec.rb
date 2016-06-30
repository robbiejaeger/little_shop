require 'rails_helper'

RSpec.describe Charity, type: :model do
   it { should validate_presence_of(:name) }
   it { should validate_presence_of(:description) }
   it { should have_many(:causes_charities) }
   it { should have_many(:causes) }
   it { should have_many(:recipients) }

   scenario "creating a slug method" do
     charity = Charity.create(name: "Charity 1",
                              description: "Charity 1 description")

     expect(charity.slug).to eq("charity-1")
 end
end
