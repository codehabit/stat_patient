FactoryGirl.define do
  factory :patient do
    date_of_birth {rand(10..100).years.ago}
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    street '123 Main'
    city 'Denver'
    state 'CO'
    zip_code '81023'
    sequence(:home_phone) {Faker::PhoneNumber.phone_number}
    sequence(:work_phone) {Faker::PhoneNumber.phone_number}
    sequence(:mobile_phone) {Faker::PhoneNumber.phone_number}
    gender {%w(male female).sample}
    social_security_number {Faker::Number.number(9)}
    email {Faker::Internet.safe_email}
  end
end

