class Pharmacy < Organization
  default_scope { where organization_type: 'pharmacy' }
  has_many :prescription_orders
end
