class Pdf < Attachment
  has_attached_file :asset
  validates_attachment :asset, content_type: { content_type: ["application/pdf", "image/jpg", "application/octet-stream"] }
  def doc_type
    "pdf"
  end
end

