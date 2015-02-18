class ChangeRecipientToPolymorphicForMessages < ActiveRecord::Migration
  def change
    add_column :messages, :recipient_type, :string
    add_column :messages, :sender_type, :string
  end
end

