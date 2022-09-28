require "webmock/cucumber"

# Disables HTTP requests, with the exception of requests to localhost
WebMock.disable_net_connect!(allow_localhost: true)

Before do |_scenario|
  auth_mock = IO.read("features/files/auth/auth_details.xml")
  details_mock = IO.read("features/files/auth/user_details.xml")

  stub_request(:get, /solr:8983/)
    .to_return(status: 200, body: "", headers: {})

  stub_request(:post, /\S.nla.gov.au\/getalibrarycard\/authenticate.xml/)
    .to_return(status: 200, body: auth_mock, headers: {})

  stub_request(:get, /\S.nla.gov.au\/getalibrarycard\/patrons\/details\/([0-9]*).xml/)
    .to_return(status: 200, body: details_mock, headers: {})
end
