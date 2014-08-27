class AddUuidToLaboratoryOrders < ActiveRecord::Migration
  def change
    add_column :laboratory_orders, :uuid, :string
  end
end
