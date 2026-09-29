# frozen_string_literal: true

module CitationHelper
  # Fields displayed in the finding aids bookmarks view, in display order,
  # excluding the search-highlight snippet
  def cite_all_fields
    @cite_all_fields ||= CatalogController.blacklight_config.index_fields.to_h.except("highlight").values
  end

  # Plain-text copy of every bookmark's fields, data-doc-id and record URL,
  # one record per block
  def cite_all_text(documents)
    documents.map do |document|
      lines = [document.normalized_title.to_s]

      cite_all_fields.each do |field|
        values = Array(document.fetch(field.field, nil)).map { |value| strip_tags(value) }.compact_blank
        lines << "#{field.label}: #{values.join("; ")}" if values.present?
      end

      lines << "data-doc-id: #{document.id}"
      lines << "#{t("cite_all.record_url")}: #{solr_document_url(document)}"
      lines.join("\n")
    end.join("\n\n")
  end

  private

  def strip_tags(value)
    value.to_s.gsub(/<[^>]*>/, "")
  end
end
