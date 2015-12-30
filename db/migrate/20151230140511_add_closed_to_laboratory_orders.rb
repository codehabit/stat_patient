class AddClosedToLaboratoryOrders < ActiveRecord::Migration
  def change
    add_column :laboratory_orders, :closed, :boolean
  end
end
