class AddRemovableToLaboratoryOrders < ActiveRecord::Migration
  def change
    add_column :laboratory_orders, :removable, :string
  end
end
