class Patient < ActiveRecord::Base
  paginates_per 20
  validates_presence_of :first_name, :last_name, :date_of_birth, :street, :city, :state, :zip_code, :home_phone, :gender, :social_security_number
  has_many :cases
  has_many :messages
  has_many :images, as: :imageable
  def full_name
    "#{first_name} #{last_name}"
  end
end

