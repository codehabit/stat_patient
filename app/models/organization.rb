class Organization < ActiveRecord::Base
  has_many :prescription_orders, foreign_key: 'pharmacy_id'
  has_many :laboratory_orders, foreign_key: 'laboratory_id'
end
