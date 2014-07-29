class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :addressable_id
      t.string :addressable_type
      t.string :type
      t.string :title
      t.string :address1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :postal_code
      t.timestamps
    end
  end
end
