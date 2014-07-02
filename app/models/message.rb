class Message < ActiveRecord::Base
  belongs_to :patient
  belongs_to :recipient, polymorphic: true
end