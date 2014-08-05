class ChangeAddressColumnNames < ActiveRecord::Migration
  def change
    rename_column :addresses, :address1, :street1
    rename_column :addresses, :address_2, :street2
  end
end
