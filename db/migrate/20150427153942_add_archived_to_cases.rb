class AddArchivedToCases < ActiveRecord::Migration
  def change
    add_column :cases, :archived, :boolean
  end
end

