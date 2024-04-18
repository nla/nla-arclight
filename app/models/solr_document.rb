# frozen_string_literal: true

# Represents a single document returned from Solr
class SolrDocument
  include Blacklight::Solr::Document
  include Arclight::SolrDocument

  # alias this field for the request link
  attribute :bibid, :string, "bibid_ssi"

  def collection_identifier
    level_ssm = self["level_ssm"]
    unitid_ssm = self["unitid_ssm"]

    level_ssm = level_ssm.join(" ") if level_ssm
    unitid_ssm = unitid_ssm.join(" ") if unitid_ssm


    [level_ssm, unitid_ssm].compact.join(", ")
  end

  # self.unique_key = 'id'

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Document::SemanticFields#field_semantics
  # and Blacklight::Document::SemanticFields#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension(Blacklight::Document::DublinCore)
end
