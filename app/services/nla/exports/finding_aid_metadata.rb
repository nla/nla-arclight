# frozen_string_literal: true

module Nla
  module Exports
    # Reads indexed archival metadata without fetching parent records or inferring rights.
    class FindingAidMetadata
      def initialize(document)
        @document = document
      end

      def self.text(value)
        spaced = value.to_s.gsub(%r{</(?:p|div|li)>|<br\s*/?>}i, " ")
        CGI.unescapeHTML(ActionView::Base.full_sanitizer.sanitize(spaced)).squish
      end

      def values(*fields)
        fields.each do |field|
          values = Array(@document[field]).map { |value| self.class.text(value) }.compact_blank.uniq
          return values if values.present?
        end
        []
      end

      def title
        values("title_ssm", "normalized_title_ssm").join("; ")
      end

      def creators
        values("creator_ssm", "creators_ssim", "creator_ssim", "collection_creator_ssm")
      end

      def dates
        values("normalized_date_ssm", "unitdate_ssm", "unitdate_inclusive_ssm")
      end

      def repository
        values("repository_ssm", "repository_ssim").join("; ")
      end

      def level
        values("level_ssm", "level_ssim").join("; ")
      end

      def identifiers
        values("unitid_ssm")
      end

      def context
        return identifiers.join("; ") if level.casecmp?("collection")

        hierarchy = values("parent_unittitles_ssm", "collection_ssim", "collection_ssm", "collection_title_tesim")
        (hierarchy.reject { |value| value == title } + identifiers + values("containers_ssim")).uniq.join("; ")
      end

      def preferred_citation
        values("prefercite_html_tesm", "prefercite_tesim").join("; ")
      end

      def resource_urls
        Array(@document["digital_objects_ssm"]).filter_map do |json|
          object = JSON.parse(json)
          next unless object.is_a?(Hash) && object["href"].is_a?(String)

          object["href"].strip.presence
        rescue JSON::ParserError, TypeError
          Rails.logger.warn("Finding aid export skipped invalid digital-object metadata")
          nil
        end.uniq
      end
    end
  end
end
