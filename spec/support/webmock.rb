require "webmock/rspec"

# Disables HTTP requests, with the exception of requests to localhost
WebMock.disable_net_connect!(
  allow_localhost: true,
  allow: "chromedriver.storage.googleapis.com"
)

RSpec.configure do |config|
  config.before do
    WebMock.stub_request(:get, /solr:8983/)
      .with(
        headers: {
          "Accept" => "*/*",
          "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "User-Agent" => "nla-arclight/#{Rails.configuration.version}"
        }
      )
      .to_return(status: 200, body: "", headers: {})

    auth_mock = IO.read("spec/files/auth/authenticate.xml")

    WebMock.stub_request(:post, /\S.nla.gov.au\/getalibrarycard\/authenticate.xml/)
      .with(
        headers: {
          "Accept" => "*/*",
          "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "Content-Length" => "0",
          "User-Agent" => "nla-arclight/#{Rails.configuration.version}"
        }
      )
      .to_return(status: 200, body: auth_mock, headers: {})

    details_mock = IO.read("spec/files/auth/user_details.xml")

    WebMock.stub_request(:get, /\S.nla.gov.au\/getalibrarycard\/patrons\/details\/([0-9]*).xml/)
      .with(
        headers: {
          "Accept" => "*/*",
          "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "User-Agent" => "nla-arclight/#{Rails.configuration.version}"
        }
      )
      .to_return(status: 200, body: details_mock, headers: {})

    WebMock.stub_request(:get, /test.nla.gov.au\/catalogue-message\/(1|1234)/)
      .with(
        headers: {
          "Accept" => "*/*",
          "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3"
        }
      )
      .to_return(status: 200, body: "", headers: {"Content-Type" => "application/json"})
  end
end
