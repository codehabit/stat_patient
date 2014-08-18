class AddUrgentToCases < ActiveRecord::Migration
  def change
    add_column :cases, :urgent, :boolean
  end
end

