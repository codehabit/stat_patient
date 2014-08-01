class AddDispenseAsWrittenToPrescriptionOrders < ActiveRecord::Migration
  def change
    add_column :prescription_orders, :dispense_only_as_written, :boolean
  end
end
