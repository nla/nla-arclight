# frozen_string_literal: true

# Represents a single document returned from Solr
class SolrDocument
  include Blacklight::Solr::Document
  include Arclight::SolrDocument

  # alias this field for the request link
  attribute :bibid, :string, "bibid_ssi"

  # alias this field for object id
  attribute :object_id, :array, "obj_id_ssim"

  # self.unique_key = 'id'

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Document::SemanticFields#field_semantics
  # and Blacklight::Document::SemanticFields#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension(Blacklight::Document::DublinCore)

  # Override from Arclight::SolrDocument to fetch viewable children from
  # finding aid.
  def digital_objects
    finding_aid = EadService.finding_aid(object_id.first)
    if finding_aid.present?
      finding_aid["children"]["manuscript"].each do |child|

      end
    end
  end
end
