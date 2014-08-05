FactoryGirl.define do
  factory :prescription_order do
    expiration_date {30.days.from_now}
  end

  factory :drug do
    name {Faker::Lorem.sentence(2)}
  end

end
