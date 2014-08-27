class AddDescriptionToLaboratoryOrders < ActiveRecord::Migration
  def change
    add_column :laboratory_orders, :description, :text
  end
end
