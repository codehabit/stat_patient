class RenameLabIdToLaboratoryOrderIdForLabItems < ActiveRecord::Migration
  def change
    rename_column :lab_items, :lab_id, :laboratory_order_id
  end
end
