class Image < Attachment
  has_attached_file :asset, styles: {landscape: "1000x1000>", web_viewer: "800x800>", thumb: "200x200>"}
  validates_attachment :asset, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end

