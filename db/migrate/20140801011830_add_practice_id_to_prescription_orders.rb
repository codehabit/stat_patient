class AddPracticeIdToPrescriptionOrders < ActiveRecord::Migration
  def change
    add_column :prescription_orders, :practice_id, :integer
  end
end
