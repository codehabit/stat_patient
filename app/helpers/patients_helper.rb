module PatientsHelper
  def address
    <<-eos
    #{@patient.street} #{@patient.street2}
    #{@patient.city}, #{@patient.state} #{@patient.zip_code}
    eos
  end
end
