# frozen_string_literal: true

# Represents a single document returned from Solr
class SolrDocument
  include Blacklight::Solr::Document
  include Arclight::SolrDocument

  # alias this field for the request link
  attribute :bibid, :string, "bibid_ssi"

  def collection_identifier
    [self["level_ssm"]&.join(" "), self["unitid_ssm"]&.join(" ")].compact.join(" ")
  end

  def extents_information
    quantity_unittype = [
      self["physdesc_quantity_ssi"],
      self["physdesc_unittype_ssi"]
    ].compact.join(" ")

    dimensions_facet = [
      self["physdesc_dimensions_ssi"],
      self["physdesc_facet_ssi"]
    ].compact.join(", ")

    if quantity_unittype.blank?
      dimensions_facet
    else
      [quantity_unittype, dimensions_facet].compact.join(", ")
    end
  end

  # self.unique_key = 'id'

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Document::SemanticFields#field_semantics
  # and Blacklight::Document::SemanticFields#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension(Blacklight::Document::DublinCore)
end
