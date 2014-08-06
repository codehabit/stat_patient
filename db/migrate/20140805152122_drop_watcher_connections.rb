class DropWatcherConnections < ActiveRecord::Migration
  def change
    drop_table :watcher_connections
  end
end
