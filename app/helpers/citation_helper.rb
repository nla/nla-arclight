# frozen_string_literal: true

module CitationHelper
  CITATION_FORMATS = {
    "apa" => "blacklight.citation.apa",
    "mla" => "blacklight.citation.mla",
    "harvard" => "citation.harvard"
  }.freeze

  def cite_all_text(documents, style:)
    documents.map do |document|
      Nla::Citations::FindingAidCitationService.new(document, solr_document_url(document)).render(style)
    end.join("\n\n")
  end

  def cite_all_html(documents, style:)
    safe_join(documents.map do |document|
      citation = Nla::Citations::FindingAidCitationService.new(document, solr_document_url(document))
      tag.p(citation.render_html(style))
    end)
  end
end
