class AddTimestampsToCaseWatchers < ActiveRecord::Migration
  def change
    add_timestamps :case_watchers
  end
end
