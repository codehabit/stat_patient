class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contact_points do |t|
      t.string :contactable_type
      t.integer :contactable_id
      t.string :contact_type
      t.string :info
      t.string :title
      t.timestamps
    end
  end
end
