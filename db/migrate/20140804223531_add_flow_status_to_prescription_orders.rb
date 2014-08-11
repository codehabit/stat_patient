class AddFlowStatusToPrescriptionOrders < ActiveRecord::Migration
  def change
    add_column :prescription_orders, :flow_status, :string
  end
end
