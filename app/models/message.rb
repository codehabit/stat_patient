class Message < ActiveRecord::Base
  has_one :image, as: :imageable
  accepts_nested_attributes_for :image
  belongs_to :patient
  belongs_to :recipient, class_name: Practitioner
  belongs_to :sender, class_name: Practitioner
  belongs_to :case
end

