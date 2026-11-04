# frozen_string_literal: true

require "csv"

module Nla
  module Exports
    ##
    # Renders bookmarked finding aid documents as a CSV string.
    #
    # Follows the catalogue CSV layout: identifiers first, titles grouped together,
    # public metadata and online links, then the finding-aid record URL last.
    class CsvExport
      TITLE_GROUP_FIELDS = %w[unitid_ssm creator_ssm collection_ssm].freeze
      ADDITIONAL_FIELDS = {
        "Preferred Citation" => "prefercite_html_tesm",
        "Conditions Governing Use" => "userestrict_html_tesm",
        "Parent Conditions Governing Access" => "parent_access_restrict_tesm",
        "Parent Conditions Governing Use" => "parent_access_terms_tesm"
      }.freeze

      def initialize(documents, fields, url_proc)
        @documents = documents
        @fields = fields.each_with_index.sort_by do |field, index|
          [TITLE_GROUP_FIELDS.index(field.key.to_s) || TITLE_GROUP_FIELDS.length, index]
        end.map(&:first)
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
        ["Bib ID", "Finding Aid ID"] +
          title_group(@fields.map(&:display_label), "Title", "Online Version") +
          ADDITIONAL_FIELDS.keys + ["Record URL"]
      end

      def row(document)
        metadata = FindingAidMetadata.new(document)
        [metadata.values("bibid_ssi").join("; "), document.id.to_s] +
          title_group(@fields.map { |field| cell(document, field) }, title(document), metadata.resource_urls.join("; ")) +
          ADDITIONAL_FIELDS.values.map { |field| metadata.values(field).join("; ") } +
          [@url_proc.call(document)]
      end

      def title_group(values, title, urls)
        collection_index = @fields.index { |field| field.key.to_s == "collection_ssm" }
        title_index = collection_index || 0
        values.insert(title_index, title).insert(title_index + (collection_index ? 2 : 1), urls)
      end

      def title(document)
        Array(document["normalized_title_ssm"]).join("; ")
      end

      def cell(document, field)
        return "" unless visible?(document, field)

        value = retrieve(document, field)
        flatten(value).join(separator(field))
      end

      def visible?(document, field)
        conditional = field.if
        return false if conditional == false
        return true unless conditional.is_a?(Proc)

        conditional.call(nil, field, document)
      rescue KeyError => error
        Rails.logger.warn("Bookmark CSV field #{field.key} skipped: #{error.class}")
        false
      end

      def retrieve(document, field)
        metadata = FindingAidMetadata.new(document)
        case field.key.to_s
        when "repository_ssm"
          metadata.values("repository_ssm", "repository_ssim")
        when "creator_ssm"
          metadata.creators
        when "collection_ssm"
          metadata.values("collection_ssm", "collection_ssim", "collection_title_tesim")
        when "accessrestrict_ssm"
          metadata.values("accessrestrict_html_tesm", "accessrestrict_ssm", "accessrestrict_tesim")
        else
          retrieve_field(document, field)
        end
      end

      def retrieve_field(document, field)
        if field.accessor == true
          document.public_send(field.field)
        elsif field.accessor.present?
          document.method(field.accessor).arity.zero? ? document.public_send(field.accessor) : document.public_send(field.accessor, field.field)
        else
          document.fetch(field.field, nil)
        end
      rescue NoMethodError, KeyError
        nil
      end

      def separator(field)
        separator = field.separator_options ? field.separator_options.values.first.to_s : "; "
        separator.match?(/<[^>]+>/) ? "; " : separator
      end

      def flatten(value)
        case value
        when Array
          value.flat_map { |item| flatten(item) }
        when Hash
          [value[:text] || value["text"], value[:href] || value["href"]].compact.flat_map { |item| flatten(item) }
        when nil
          []
        else
          [strip_tags(value)]
        end
      end

      def strip_tags(value)
        CGI.unescapeHTML(ActionView::Base.full_sanitizer.sanitize(value.to_s))
      end
    end
  end
end
