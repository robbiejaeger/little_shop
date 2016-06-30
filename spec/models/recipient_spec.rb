require 'rails_helper'

RSpec.describe Recipient, type: :model do
   it { should validate_presence_of(:name) }
   it { should validate_presence_of(:description) }
   it { should have_many(:need_items) }
   it { should have_many(:donation_items) }
   it { should belong_to(:charity) }
end
