class Drug < ActiveRecord::Base
  has_many :prescription_orders
  has_many :drug_diagnosis_assignments

  def dispense
    "#{dispense_amount} / #{dispense_frequency.upcase}"
  end

  def selection_name
    "#{name} #{strength}"
  end

end
