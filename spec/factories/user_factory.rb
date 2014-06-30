FactoryGirl.define do
  factory :user do
    first_name "Bob"
    last_name "Dentist"
    email "non@non.non"
    password 'sec5ret)ne'
    password_confirmation 'sec5ret)ne'
  end
end
