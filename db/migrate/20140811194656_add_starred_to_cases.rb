class AddStarredToCases < ActiveRecord::Migration
  def change
    add_column :cases, :starred, :boolean
  end
end

