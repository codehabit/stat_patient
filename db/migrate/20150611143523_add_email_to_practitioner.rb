class AddEmailToPractitioner < ActiveRecord::Migration
  def change
    add_column :practitioners, :email, :string
  end
end
