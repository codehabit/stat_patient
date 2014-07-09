class RenameSenderIdToOriginatorId < ActiveRecord::Migration
  def change
    rename_column :cases, :sender_id, :originator_id
  end
end
