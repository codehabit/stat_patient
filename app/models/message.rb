class Message < ActiveRecord::Base
  has_one :images, as: :imageable
  belongs_to :patient
  belongs_to :recipient, class_name: Practitioner
  belongs_to :sender, class_name: Practitioner
  belongs_to :case
end

