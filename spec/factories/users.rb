FactoryGirl.define do
  factory :user do
    confirmed_at Time.now
    role 'worker'
    firstname "Usie"
    lastname "Userson"
    phone "1234567"
    email "test@example.com"
    password "please123"

    trait :admin do
      role 'admin'
    end

  end
end
