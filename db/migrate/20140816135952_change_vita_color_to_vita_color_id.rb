class ChangeVitaColorToVitaColorId < ActiveRecord::Migration
  def change
    rename_column :laboratory_orders, :vita_color, :vita_color_id
  end
end
