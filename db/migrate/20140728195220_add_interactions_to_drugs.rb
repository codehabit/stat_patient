class AddInteractionsToDrugs < ActiveRecord::Migration
  def change
    add_column :drugs, :interactions, :text
    add_column :drugs, :pregnancy_lactating_precautions, :text
  end
end
