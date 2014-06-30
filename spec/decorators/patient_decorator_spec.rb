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
end

