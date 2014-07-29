class ChangeImageableToAttachableForAttachments < ActiveRecord::Migration
  def up
    rename_column :attachments, :imageable_id, :attachable_id
    rename_column :attachments, :imageable_type, :attachable_type
  end
end
