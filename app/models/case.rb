class Case < ActiveRecord::Base
  belongs_to :patient
  belongs_to :recipient, polymorphic: true
  belongs_to :originator, class_name: Practitioner
  has_many :images, as: :imageable
  validates :recipient, presence: true
  validates :patient, presence: true
end

