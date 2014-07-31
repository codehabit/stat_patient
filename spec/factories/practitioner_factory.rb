FactoryGirl.define do
  factory :practitioner do
    sequence(:first_name) {|n| "#{n}Sam"} 
    last_name 'Practitioner'
    specialty 'Teeth'
  end
end

