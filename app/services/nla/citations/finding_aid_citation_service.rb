# frozen_string_literal: true

module Nla
  module Citations
    # Plain-text archival citations. Missing dates remain undated; names are kept as supplied.
    class FindingAidCitationService
      STYLES = %w[apa mla harvard].freeze

      def initialize(document, record_url)
        @metadata = Nla::Exports::FindingAidMetadata.new(document)
        @record_url = record_url
      end

      def render(style)
        raise ArgumentError, "Unknown citation style" unless STYLES.include?(style)

        public_send(style)
      end

      def render_html(style)
        raise ArgumentError, "Unknown citation style" unless STYLES.include?(style)

        public_send(style, html: true)
      end

      def apa(html: false)
        author = @metadata.creators.join("; ")
        description = join_parts([title(html: html), "[#{@metadata.level.presence || "Archival material"}]"].compact_blank, " ", html: html)
        heading = author.present? ? ["#{author} (#{date})", description] : [description, "(#{date})"]
        sentences(*heading, @metadata.context, @metadata.repository, @record_url, html: html)
      end

      def mla(html: false)
        collection = @metadata.level.casecmp?("collection")
        quoted_title = if @metadata.title.present?
          join_parts(["“", title(html: html && collection), ("." unless @metadata.title.match?(/[.!?]\z/)), "”"], "", html: html)
        end
        sentences(@metadata.creators.join("; "), quoted_title, @metadata.dates.join("; "),
          context(html: html, emphasize_collection: !collection), @metadata.repository, @record_url, html: html)
      end

      def harvard(html: false)
        heading = [@metadata.creators.join("; "), date].compact_blank.join(" ")
        join_parts([heading, title(html: html), @metadata.context, @metadata.repository, @record_url].compact_blank, ", ", html: html)
      end

      private

      def date
        @metadata.dates.join("; ").presence || "n.d."
      end

      def title(html:)
        (html && @metadata.title.present?) ? helpers.tag.em(@metadata.title) : @metadata.title
      end

      def context(html:, emphasize_collection:)
        return @metadata.context unless html && emphasize_collection

        collection_title = @metadata.collection_titles.first
        parts = @metadata.context_parts.map do |part|
          (part == collection_title) ? helpers.tag.em(part) : part
        end
        join_parts(parts, "; ", html: true)
      end

      def helpers
        ActionController::Base.helpers
      end

      def join_parts(parts, separator, html:)
        html ? helpers.safe_join(parts.compact, separator) : parts.compact.join(separator)
      end

      def sentences(*parts, html: false)
        punctuated = parts.compact_blank.map do |part|
          text = html ? helpers.strip_tags(part) : part
          (part == @record_url || text.match?(/[.!?]”?\z/)) ? part : join_parts([part, "."], "", html: html)
        end
        join_parts(punctuated, " ", html: html)
      end
    end
  end
end
