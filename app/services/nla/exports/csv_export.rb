# frozen_string_literal: true

require "csv"

module Nla
  module Exports
    ##
    # Renders bookmarked finding aid documents as a CSV string.
    #
    # Columns: title and bookmark-view fields, supplied citation/rights statements
    # and digital-resource URLs, then data-doc-id (Solr id) and the record URL.
    class CsvExport
      ADDITIONAL_FIELDS = {
        "Preferred Citation" => "prefercite_html_tesm",
        "Conditions Governing Access (Full Statement)" => "accessrestrict_html_tesm",
        "Conditions Governing Use" => "userestrict_html_tesm",
        "Parent Conditions Governing Access" => "parent_access_restrict_tesm",
        "Parent Conditions Governing Use" => "parent_access_terms_tesm"
      }.freeze

      def initialize(documents, fields, url_proc)
        @documents = documents
        @fields = fields
        @url_proc = url_proc
      end

      def render
        CSV.generate do |csv|
          csv << header
          @documents.each do |document|
            csv << row(document).map { |value| spreadsheet_safe(value) }
          end
        end
      end

      private

      def spreadsheet_safe(value)
        value.match?(/\A(?:\s*[=+@-]|[\t\r\n])/) ? "'#{value}" : value
      end

      def header
        ["Title"] + @fields.map { |field| field.label } + ADDITIONAL_FIELDS.keys + ["Online Resources", "data-doc-id", "Record URL"]
      end

      def row(document)
        metadata = FindingAidMetadata.new(document)
        [title(document)] + @fields.map { |field| cell(document, field) } +
          ADDITIONAL_FIELDS.values.map { |field| metadata.values(field).join("; ") } +
          [metadata.resource_urls.join("; "), document.id.to_s, @url_proc.call(document)]
      end

      def title(document)
        Array(document["normalized_title_ssm"]).join("; ")
      end

      def cell(document, field)
        values = Array(document.fetch(field.field, nil))
        values.map { |value| strip_tags(value) }.compact_blank.join("; ")
      end

      def strip_tags(value)
        CGI.unescapeHTML(ActionView::Base.full_sanitizer.sanitize(value.to_s))
      end
    end
  end
end
