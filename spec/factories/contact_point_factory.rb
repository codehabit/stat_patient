FactoryGirl.define do
  factory :contact_point do

    trait :email do
      contact_type 'email'
      info {Faker::Internet.safe_email}
    end
    trait :work_phone do
      contact_type 'work_phone'
      info {Faker::PhoneNumber.phone_number}
    end
    trait :work_fax do
      contact_type 'work_fax'
      info {Faker::PhoneNumber.phone_number}
    end
  end
end
