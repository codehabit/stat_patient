class AddReadToCases < ActiveRecord::Migration
  def change
    add_column :cases, :read, :boolean
  end
end
