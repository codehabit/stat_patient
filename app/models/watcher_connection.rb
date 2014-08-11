class WatcherConnection < ActiveRecord::Base
  belongs_to :watchable, polymorphic: true
  belongs_to :watcher, polymorphic: true
end

