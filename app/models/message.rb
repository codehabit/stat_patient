class Message < ActiveRecord::Base
  has_many :images, as: :imageable
  accepts_nested_attributes_for :images
  belongs_to :patient
  belongs_to :recipient, class_name: Practitioner
  belongs_to :sender, class_name: Practitioner
  belongs_to :case
end

