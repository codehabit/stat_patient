class ChangeVitaNumberToVitaColor < ActiveRecord::Migration
  def change
    rename_column :laboratory_orders, :vita_number, :vita_color
  end
end

