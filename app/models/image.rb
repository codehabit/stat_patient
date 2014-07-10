class Image < ActiveRecord::Base
  has_attached_file :asset, styles: {thumb: "200x200>"}
  validates_attachment :asset, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  belongs_to :imageable, polymorphic: true
end

