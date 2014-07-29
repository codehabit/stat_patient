class Message < ActiveRecord::Base
  has_many :attachments, as: :attachable
  accepts_nested_attributes_for :attachments
  belongs_to :patient
  belongs_to :recipient, class_name: Practitioner
  belongs_to :sender, class_name: Practitioner
  belongs_to :case
end

