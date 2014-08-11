class CreateCaseWatchers < ActiveRecord::Migration
  def change
    create_table :case_watchers do |t|
      t.integer :case_id
      t.integer :watcher_id
      t.string :watcher_type
    end
  end
end

