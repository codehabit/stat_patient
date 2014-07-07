class AddUserIdToPractitioner < ActiveRecord::Migration
  def change
    add_column :practitioners, :user_id, :integer
  end
end
