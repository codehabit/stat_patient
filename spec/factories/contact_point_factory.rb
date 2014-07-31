FactoryGirl.define do
  factory :contact_point do

    trait :email do
      contact_type 'email'
      sequence(:info) {|n| "example#{n}@non.non"}
    end
    trait :work_phone do
      contact_type 'work_phone'
      sequence(:info) {|n| "111-222-3333"}
    end
    trait :work_fax do
      contact_type 'work_fax'
      sequence(:info) {|n| "111-222-3333"}
    end
  end
end
