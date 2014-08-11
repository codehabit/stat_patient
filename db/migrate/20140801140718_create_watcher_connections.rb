class CreateWatcherConnections < ActiveRecord::Migration
  def change
    create_table :watcher_connections do |t|
      t.integer :watchable_id
      t.integer :watchable_type
      t.integer :watcher_id
      t.integer :watcher_type
    end
  end
end

