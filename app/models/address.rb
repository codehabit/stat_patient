class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true

  def full_address
    "#{street1} #{street2}, #{city}, #{state} #{postal_code}"
  end
end
