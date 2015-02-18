class MoveAnnotationsToAttachments < ActiveRecord::Migration
  def change
    rename_column :annotations, :tooth_chart_id, :attachment_id
  end
end
