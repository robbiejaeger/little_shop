FactoryGirl.define do

  factory :cause do
    name { generate(:cause_name) }
  end

  sequence :cause_name do |n|
    "Cause-#{n}"
  end

  factory :charity do
    name { generate(:charity_name)}
    description { generate(:charity_description)}
  end

  sequence :charity_name do |n|
    "Charity-#{n}"
  end

  sequence :charity_description do |n|
    "This is description for Charity-#{n}"
  end

  factory :needs_category do
    name { generate(:needs_category_name)}
  end

  sequence :needs_category_name do |n|
    "Needs-Category-#{n}"
  end


  factory :need do
    name { generate(:need_name)}
    description { generate(:need_description)}
    price { generate(:need_price)}
    needs_category
  end

  sequence :need_name do |n|
    "Need-#{n}"
  end

  sequence :need_description do |n|
    "This is description for Need-#{n}"
  end

  sequence :need_price, [10, 20, 30].cycle do |n|
    n
  end

  factory :user do
    username { generate(:username)}
    password "password"
    email "fake@fake.com"
  end

  sequence :username do |n|
    "user#{n}"
  end

  factory :recipient do
    name { generate(:recipient_name)}
    description { generate(:recipient_description)}
    charity
  end

  factory :need_item do
    quantity 1
    need
    recipient
    deadline Date.today
  end


  sequence :recipient_name do |n|
    "Recipient-#{n}"
  end

  sequence :recipient_description do |n|
    "This is description for Recipient-#{n}"
  end


  factory :future_need_item, class: NeedItem do
    quantity 1
    need
    recipient
    deadline 5.days.from_now
  end

  factory :future_need_item_multiple, class: NeedItem do
    quantity 10
    need
    recipient
    deadline 5.days.from_now
  end

  factory :past_need_item, class: NeedItem do
    quantity 1
    need
    recipient
    deadline 5.days.ago
  end

  factory :donation_item do
    quantity 1
    donation
    need_item
  end

  factory :donation do
    user
  end

end
