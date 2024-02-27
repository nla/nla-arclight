# frozen_string_literal: true

module Nla
  module Routes
    class Iiif
      def initialize(defaults = {})
        @defaults = defaults
      end

      def call(mapper, _options = {})
        mapper.member do
          mapper.get "iiif"
        end
      end
    end
  end
end
