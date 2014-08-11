class ChangeImageableUuidToAttachableUuid < ActiveRecord::Migration
  def change
    rename_column :attachments, :imageable_uuid, :attachable_uuid
  end
end
