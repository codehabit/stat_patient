FactoryGirl.define do
  factory :organization do
    name {Faker::Company.name}
  end

  factory :practice do
    name {Faker::Company.name}
  end

  factory :laboratory do
    name {Faker::Company.name}
    addresses { build_list :address, 1 }
  end

  factory :pharmacy do
    name {Faker::Company.name}
  end
end
