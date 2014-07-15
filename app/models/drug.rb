class Drug < ActiveRecord::Base
  has_many :prescription_orders
end
