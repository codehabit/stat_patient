class AddNewReplyToCases < ActiveRecord::Migration
  def change
    add_column :cases, :new_reply, :boolean
  end
end

