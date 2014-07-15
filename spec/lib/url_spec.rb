require 'url'

describe Url do
  it "builds the url from the request" do
    request = double(:request, protocol: "http://", host: "statqa.com", port: "1234")
    expect(Url.from_request(request)).to eq "http://statqa.com:1234"
  end

  it "omits the port if port is 80" do
    request = double(:request, protocol: "http://", host: "statqa.com", port: "80")
    expect(Url.from_request(request)).to eq "http://statqa.com"
  end
end
