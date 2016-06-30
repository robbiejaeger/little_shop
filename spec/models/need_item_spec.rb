require 'rails_helper'

RSpec.describe NeedItem, type: :model do
   it { should belong_to(:need) }
   it { should belong_to(:recipient) }
   it { should have_many(:donation_items) }
end
