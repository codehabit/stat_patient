class CreateVisitArtifactAttachments < ActiveRecord::Migration
  def change
    create_table :visit_artifact_attachments do |t|
      t.integer :visit_id
      t.integer :artifact_id
      t.string :artifact_type
      t.integer :created_by_user_id
      t.timestamps
    end
  end
end
