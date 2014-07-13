class AddTimestampsToPractitioners < ActiveRecord::Migration
  def change
    add_column :practitioners, :created_at, :datetime
    add_column :practitioners, :updated_at, :datetime
  end
end
