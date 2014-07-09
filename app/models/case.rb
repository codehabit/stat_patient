class Case < ActiveRecord::Base
  belongs_to :patient
  belongs_to :recipient, polymorphic: true
  belongs_to :originator, class_name: Practitioner
  has_attached_file :image, styles: {thumb: "200x200>"}
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  has_many :images, as: :imageable
  validates :recipient, presence: true
  validates :patient, presence: true
end

