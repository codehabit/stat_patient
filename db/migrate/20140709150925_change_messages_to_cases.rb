class ChangeMessagesToCases < ActiveRecord::Migration
  def change
    rename_table :messages, :cases
  end
end

