class ChangeShippingMethodToStringForLaboratoryOrders < ActiveRecord::Migration
  def change
    change_column :laboratory_orders, :shipping_method_id, :string
    rename_column :laboratory_orders, :shipping_method_id, :shipping_method_name
  end
end

