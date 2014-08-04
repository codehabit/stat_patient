class AddLabelToPrescriptionOrders < ActiveRecord::Migration
  def change
    add_column :prescription_orders, :label, :boolean
  end
end
