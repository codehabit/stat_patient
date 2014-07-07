class Message < ActiveRecord::Base
  belongs_to :patient
  belongs_to :recipient, polymorphic: true
  belongs_to :sender, class_name: Practitioner
  has_attached_file :image, styles: {thumb: "200x200>"}
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  # has_many :images
  # accepts_nested_attributes_for :images
  validates :recipient, presence: true
end

