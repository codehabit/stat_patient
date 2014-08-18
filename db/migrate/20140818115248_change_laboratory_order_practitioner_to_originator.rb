class ChangeLaboratoryOrderPractitionerToOriginator < ActiveRecord::Migration
  def change
    rename_column :laboratory_orders, :practitioner_id, :originator_id
  end
end
