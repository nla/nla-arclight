# frozen_string_literal: true

module Nla
  module Exports
    # Finding aids are archival descriptions, not MARC catalogue records.
    class RisExport
      def initialize(documents, url_proc)
        @documents = documents
        @url_proc = url_proc
      end

      def render
        @documents.map { |document| record(document) }.join
      end

      private

      def record(document)
        metadata = FindingAidMetadata.new(document)
        lines = ["TY  - MANSCPT"]
        metadata.creators.each { |creator| lines << "AU  - #{creator}" }
        add(lines, "TI", metadata.title)
        add(lines, "DA", metadata.dates.join("; "))
        add(lines, "DB", metadata.repository)
        add(lines, "CN", metadata.identifiers.join("; "))
        add(lines, "AB", metadata.values("scopecontent_ssm", "scopecontent_html_tesm", "abstract_html_tesm").join("; "))
        add(lines, "AN", @url_proc.call(document))
        resource_urls = metadata.resource_urls
        resource_urls.each { |url| add(lines, "UR", url) }
        resource_urls.drop(1).each { |url| add(lines, "N1", "Online resource: #{url}") }
        add(lines, "N1", "Archival context: #{metadata.context}") if metadata.context.present?
        add(lines, "N1", "Preferred citation: #{metadata.preferred_citation}") if metadata.preferred_citation.present?
        %w[accessrestrict_html_tesm userestrict_html_tesm parent_access_restrict_tesm parent_access_terms_tesm].each do |field|
          metadata.values(field).each { |value| add(lines, "N1", "#{rights_label(field)}: #{value}") }
        end
        (lines + ["ER  - "]).join("\n") + "\n\n"
      end

      def add(lines, tag, value)
        lines << "#{tag}  - #{value.to_s.gsub(/[\r\n]+/, " ")}" if value.present?
      end

      def rights_label(field)
        {
          "accessrestrict_html_tesm" => "Conditions Governing Access",
          "userestrict_html_tesm" => "Conditions Governing Use",
          "parent_access_restrict_tesm" => "Parent Conditions Governing Access",
          "parent_access_terms_tesm" => "Parent Conditions Governing Use"
        }.fetch(field)
      end
    end
  end
end
