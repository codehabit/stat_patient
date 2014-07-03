require 'spec_helper'

describe PatientDecorator do
  it "makes the full name" do
    patient = create(:patient, first_name: "Miles", last_name: "Davis", middle_initial: "X")
    expect(patient.decorate.full_name).to eq "Miles X Davis"
  end

  it "doesn't need a middle initial" do
    patient = create(:patient, first_name: "Miles", last_name: "Davis")
    expect(patient.decorate.full_name).to eq "Miles Davis"
  end

  it "appends the dob" do
    birthday = DateTime.new(1926, 5, 26)
    patient = create(:patient, first_name: "Miles", last_name: "Davis", date_of_birth: birthday)
    expect(patient.decorate.full_name_with_dob).to eq "Miles Davis - #{birthday.strftime("%m/%d/%Y")}"
  end
end

