class Organization < ActiveRecord::Base
  has_many :prescription_orders, foreign_key: 'pharmacy_id'
  has_many :laboratory_orders, foreign_key: 'laboratory_id'
  has_many :organization_memberships
  has_many :members, through: :organization_memberships, source: :practitioner
  has_many :contact_points, as: :contactable
  has_many :addresses, as: :addressable
end

