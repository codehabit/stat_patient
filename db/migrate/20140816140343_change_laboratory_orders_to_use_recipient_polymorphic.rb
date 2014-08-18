class ChangeLaboratoryOrdersToUseRecipientPolymorphic < ActiveRecord::Migration
  def change
    rename_column :laboratory_orders, :laboratory_id, :recipient_id
    add_column :laboratory_orders, :recipient_type, :string
  end
end
