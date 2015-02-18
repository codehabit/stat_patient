class AddLastActivityDateToCases < ActiveRecord::Migration
  def change
    add_column :cases, :last_activity_date, :datetime
  end
end
