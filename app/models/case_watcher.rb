class CaseWatcher < ActiveRecord::Base
  belongs_to :case
  belongs_to :watcher, polymorphic: :true
end

