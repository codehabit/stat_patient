FactoryGirl.define do
  factory :patient do
    date_of_birth 30.years.ago
    first_name 'Billy'
    last_name 'Bob'
    street '123 Main'
    city 'Normal'
    state 'IL'
    zip_code '99999'
    home_phone '312 222 1234'
    gender 'A'
    social_security_number '111-22-2222'
  end
end

