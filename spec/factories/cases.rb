FactoryGirl.define do
  factory :case do
    recipient factory: :practitioner
    patient factory: :patient
  end

  factory :message do

  end
end

