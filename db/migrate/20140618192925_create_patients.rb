class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.string :middile_initial
      t.date :date_of_birth
      t.timestamps
    end
  end
end

