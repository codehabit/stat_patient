class AddPassthroughIdToCases < ActiveRecord::Migration
  def change
    add_column :cases, :passthrough_id, :integer
  end
end
