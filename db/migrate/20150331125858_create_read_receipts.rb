class CreateReadReceipts < ActiveRecord::Migration
  def change
    create_table :read_receipts do |t|
      t.integer :practitioner_id
      t.integer :read_case_id
      t.timestamps
    end
  end
end

