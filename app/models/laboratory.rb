class Laboratory < Organization
  default_scope { where organization_type: 'laboratory' }
  has_many :laboratory_orders
end

