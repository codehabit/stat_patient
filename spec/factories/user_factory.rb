FactoryGirl.define do
  factory :user do
    first_name "Bob"
    last_name "Dentist"
    sequence(:email) {|n| "#{n}-non@non.non"}
    password 'sec5ret)ne'
    password_confirmation 'sec5ret)ne'
    practitioner factory: :practitioner
  end
end
