class MsDoc < Attachment
  has_attached_file :asset
  validates_attachment :asset, content_type: {
    content_type: [
      "application/vnd.openxmlformats-officedocument.presentationml.presentation",
      "application/octet-stream",
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
      "application/msword"
    ]
  }

  def self.ms_type? content_type
    content_type =~ /officedocument/ || content_type == "application/msword" || content_type == "application/octet-stream"
  end
end

