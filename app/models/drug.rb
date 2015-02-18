class Drug < ActiveRecord::Base
  has_many :prescription_orders, foreign_key: :drug_uuid, primary_key: :uuid
  has_many :drug_diagnosis_assignments, foreign_key: :drug_uuid, primary_key: :uuid

  def dispense
    "#{dispense_amount} / #{dispense_frequency.upcase}"
  end

  def selection_name
    "#{name} #{strength}"
  end

end
