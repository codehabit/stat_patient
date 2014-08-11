class Message < ActiveRecord::Base
  has_many :attachments, as: :attachable
  accepts_nested_attributes_for :attachments
  belongs_to :patient
  belongs_to :recipient, polymorphic: true
  belongs_to :sender, polymorphic: true
  belongs_to :case
end

