class Drug < ActiveRecord::Base
  has_many :prescription_orders
  def dispense
    "#{dispense_amount} / #{dispense_frequency.upcase}"
  end
end
