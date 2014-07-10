class CreateMessagesPartDeaux < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :body
      t.integer :sender_id
      t.integer :recipient_id
      t.integer :patient_id
      t.integer :case_id
      t.timestamps
    end
  end
end

