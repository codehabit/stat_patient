class PrescriptionOrderNames < ActiveRecord::Migration
  def up
    rename_column :drugs, :pharmacy_instructions, :rx_instructions
    remove_column :drugs, :dispense_frequency
    rename_column :prescription_orders, :dispense, :dispense_amount
    rename_column :prescription_orders, :instructions, :rx_instructions
  end

  def down
    rename_column :drugs, :rx_instructions, :pharmacy_instructions
    add_column :drugs, :dispense_frequency, :string
    rename_column :prescription_orders, :dispense_amount, :dispense
    rename_column :prescription_orders, :rx_instructions, :instructions
  end
end
