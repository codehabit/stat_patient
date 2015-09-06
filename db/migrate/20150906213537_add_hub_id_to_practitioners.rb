class AddHubIdToPractitioners < ActiveRecord::Migration
  def change
    add_column :practitioners, :hub_id, :integer
  end
end
