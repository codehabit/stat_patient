require 'pry'
require 'patient_params'

describe PatientParams do
  it "converts day month year into birth date" do
    incoming = {
      patient: {},
      day_of_birth: "14",
      month_of_birth: "12",
      year_of_birth: "1974"
    }
    params = PatientParams.new(incoming)
    expect(params.as_hash[:patient][:date_of_birth]).to eq DateTime.new(1974, 12, 14)
  end

  it "converts SSN parts to SSN string" do
    incoming = {
      patient: {},
      social_pre: "222",
      social_mid: "22",
      social_suffix: "2222"
    }
    params = PatientParams.new(incoming)
    expect(params.as_hash[:patient][:social_security_number]).to eq "222-22-2222"
  end

  it "has the original values as well" do
    incoming = {
      patient: {
        first_name: "Sally"
      }
    }
    params = PatientParams.new(incoming)
    expect(params.as_hash[:patient][:first_name]).to eq "Sally"
  end
end

