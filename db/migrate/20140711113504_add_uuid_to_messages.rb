class AddUuidToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :uuid, :string
  end
end
