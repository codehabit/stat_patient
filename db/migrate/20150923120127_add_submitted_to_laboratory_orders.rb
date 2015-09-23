class AddSubmittedToLaboratoryOrders < ActiveRecord::Migration
  def change
    add_column :laboratory_orders, :submitted, :boolean
  end
end
