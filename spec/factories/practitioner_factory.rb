FactoryGirl.define do
  factory :practitioner do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    specialty 'Teeth'
  end
end

