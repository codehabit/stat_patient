class Patient < ActiveRecord::Base
  paginates_per 20
  validates_presence_of :first_name, :last_name, :date_of_birth, :street, :city, :state, :zip_code, :home_phone, :gender, :social_security_number
  has_many :cases
  has_many :messages
  has_many :attachments, as: :attachable
  has_many :prescription_orders
  has_many :laboratory_orders
  has_many :visits
  has_many :practitioner_patients
  has_many :practitioners, through: :practitioner_patients

  def practitioners
    cases.map(&:originator)
  end
end

