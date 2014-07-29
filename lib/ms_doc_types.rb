module MsDocTypes
  class << self
    def all
      {
        "application/vnd.openxmlformats-officedocument.presentationml.presentation" => "ms_ppt",
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" => "ms_word",
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" => "ms_excel",
        "application/msword" => "ms_word",
        "application/octet-stream" => "ms_excel"
      }
    end
  end
end

