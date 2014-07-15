class Url
  def self.from_request(request)
    port = request.port.to_i == 80 ? "" : ":#{request.port}"
    "#{request.protocol}#{request.host}#{port}"
  end
end
