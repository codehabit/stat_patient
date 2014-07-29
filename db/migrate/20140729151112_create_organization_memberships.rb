class CreateOrganizationMemberships < ActiveRecord::Migration
  def change
    create_table :organization_memberships do |t|
      t.integer :organization_id
      t.integer :practitioner_id
      t.string :role
      t.timestamps
    end
  end
end
