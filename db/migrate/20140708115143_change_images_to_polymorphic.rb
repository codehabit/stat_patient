class ChangeImagesToPolymorphic < ActiveRecord::Migration
  def up
    drop_table :images
    create_table :images do |t|
      t.attachment :asset
      t.integer :imageable_id
      t.string :imageable_type
      t.integer :uploaded_by_id
      t.timestamps
    end
  end

  def down
    drop_table :images
    create_table :images do |t|
      t.attachment :image
      t.integer :message_id
    end
  end
end

