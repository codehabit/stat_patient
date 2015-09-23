class AddFlavorToCases < ActiveRecord::Migration
  def change
    add_column :cases, :flavor, :string
  end
end
