# frozen_string_literal: true

require "csv"

module Nla
  module Exports
    ##
    # Renders bookmarked finding aid documents as a CSV string.
    #
    # Columns: the title, the fields displayed in the bookmarks view
    # (in display order), then the data-doc-id (Solr id) and the record URL.
    class CsvExport
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
        ["Title"] + @fields.map { |field| field.label } + ["data-doc-id", "Record URL"]
      end

      def row(document)
        [title(document)] + @fields.map { |field| cell(document, field) } + [document.id.to_s, @url_proc.call(document)]
      end

      def title(document)
        Array(document.normalized_title).join("; ")
      end

      def cell(document, field)
        values = Array(document.fetch(field.field, nil))
        values.map { |value| strip_tags(value) }.compact_blank.join("; ")
      end

      def strip_tags(value)
        value.to_s.gsub(/<[^>]*>/, "")
      end
    end
  end
end
