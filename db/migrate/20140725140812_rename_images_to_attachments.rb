class RenameImagesToAttachments < ActiveRecord::Migration
  def change
    rename_table :images, :attachments
  end
end

