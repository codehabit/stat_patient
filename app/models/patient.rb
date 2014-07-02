class Patient < ActiveRecord::Base
  paginates_per 20
  validates_presence_of :first_name, :last_name, :date_of_birth, :street, :city, :state, :zip_code, :home_phone, :gender, :social_security_number
end

