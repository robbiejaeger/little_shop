FactoryGirl.define do

  factory :category_charity do
    name { generate(:category_charity_name) }
  end

  sequence :category_charity_name, ["Environment", "Youth", "Women"].cycle do |n|
    "#{n}"
  end

end
