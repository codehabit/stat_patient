class AddPrimaryPhoneToPractitioners < ActiveRecord::Migration
  def change
    add_column :practitioners, :primary_phone, :string
  end
end
