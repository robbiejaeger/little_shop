require 'rails_helper'

RSpec.describe CategoryCharity, type: :model do
  it "has a name" do
    cat_char1 = create(:category_charity)
    expect(cat_char1.name).to eq("Environment")
  end
end
