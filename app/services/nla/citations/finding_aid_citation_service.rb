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
        citation = render(style)
        emphasized = if style == "mla"
          @metadata.values("parent_unittitles_ssm", "collection_ssim", "collection_ssm", "collection_title_tesim").first
        else
          @metadata.title
        end
        helpers = ActionController::Base.helpers
        return helpers.safe_join([citation]) if emphasized.blank? || citation.exclude?(emphasized)

        before, after = citation.split(emphasized, 2)
        helpers.safe_join([before, helpers.tag.em(emphasized), after])
      end

      def apa
        author = @metadata.creators.join("; ")
        description = [@metadata.title, "[#{@metadata.level.presence || "Archival material"}]"].compact_blank.join(" ")
        heading = author.present? ? ["#{author} (#{date})", description] : [description, "(#{date})"]
        sentences(*heading, @metadata.context, @metadata.repository, @record_url)
      end

      def mla
        title = @metadata.title
        quoted_title = title.present? ? "“#{title}#{"." unless title.match?(/[.!?]\z/)}”" : nil
        sentences(@metadata.creators.join("; "), quoted_title, @metadata.dates.join("; "),
          @metadata.context, @metadata.repository, @record_url)
      end

      def harvard
        heading = [@metadata.creators.join("; "), date].compact_blank.join(" ")
        [heading, @metadata.title, @metadata.context, @metadata.repository, @record_url].compact_blank.join(", ")
      end

      private

      def date
        @metadata.dates.join("; ").presence || "n.d."
      end

      def sentences(*parts)
        parts.compact_blank.map do |part|
          (part == @record_url || part.match?(/[.!?]”?\z/)) ? part : "#{part}."
        end.join(" ")
      end
    end
  end
end
