class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :patient_id
      t.integer :practitioner_id
      t.integer :organization_id
      t.datetime :visit_start_dttm
      t.integer :created_by_user_id
      t.timestamps
    end
  end
end
