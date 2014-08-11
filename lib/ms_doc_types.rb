module MsDocTypes
  class << self
    def all
      {
        "application/vnd.openxmlformats-officedocument.presentationml.presentation" => "powerpoint",
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" => "word",
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" => "excel",
        "application/msword" => "word",
        "application/octet-stream" => "excel"
      }
    end
  end
end

