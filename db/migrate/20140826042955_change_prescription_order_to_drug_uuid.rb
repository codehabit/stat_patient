class ChangePrescriptionOrderToDrugUuid < ActiveRecord::Migration
  def change
    remove_column :prescription_orders, :drug_id, :integer
    add_column :prescription_orders, :drug_uuid, :string
  end
end
