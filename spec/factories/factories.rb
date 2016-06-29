FactoryGirl.define do

  factory :cause do
    name { generate(:cause_name) }
  end

  sequence :cause_name do |n|
    "#{n} Cause"
  end

  factory :charity do
    name { generate(:charity_name)}
    description { generate(:charity_description)}
  end

  sequence :charity_name do |n|
    "#{n} Charity"
  end

  sequence :charity_description do |n|
    "This is description for #{n} Charity"
  end

  factory :needs_category do
    name { generate(:needs_category_name)}
  end

  sequence :needs_category_name do |n|
    "#{n} Needs Category"
  end


  factory :need do
    name { generate(:need_name)}
    description { generate(:need_description)}
    price { generate(:need_price)}
    needs_category
  end


  sequence :need_name do |n|
    "#{n} Need"
  end

  sequence :need_description do |n|
    "This is description for #{n} Need"
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


  sequence :recipient_name do |n|
    "#{n} Recipient"
  end

  sequence :recipient_description do |n|
    "This is description for #{n} Recipient"
  end


  factory :future_need_item, class: NeedItem do
    quantity 1
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

  factory :donation do
    user
  end

end
