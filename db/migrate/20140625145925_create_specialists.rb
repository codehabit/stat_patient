class CreateSpecialists < ActiveRecord::Migration
  def change
    create_table :specialists do |t|
      t.string :first_name
      t.string :last_name
      t.string :practice_name
      t.string :email
      t.string :specialty
      t.string :phone
    end
  end
end
