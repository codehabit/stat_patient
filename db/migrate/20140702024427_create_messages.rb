class CreateCases < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :case_number
      t.references :patient
      t.references :recipient, polymorphic: true
      t.text :notes

      t.timestamps
    end
  end
end
