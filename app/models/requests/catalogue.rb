module Requests
  class Catalogue
    attr_reader :document

    delegate :bibid, to: :document

    def initialize(document)
      @document = document
    end

    def url
      request_config["request_url"] % [bibid]
    end

    def request_config
      document.repository_config&.request_config_for_type("catalogue")
    end
  end
end
