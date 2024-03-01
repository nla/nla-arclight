# frozen_string_literal: true

# Represents a single document returned from Solr
class SolrDocument
  include Blacklight::Solr::Document
  include Arclight::SolrDocument

  DISPLAYABLE_DIGITAL_STATUS = %w[captured partially-captured].freeze

  # alias this field for the request link
  attribute :bibid, :string, "bibid_ssi"

  # alias this field for object id
  attribute :object_id, :string, "ref_ssi"

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
    finding_aid = EadService.finding_aid("nla.obj-#{object_id}")
    digital_objects = finding_aid["children"]["manuscript"].reject do |child|
      DISPLAYABLE_DIGITAL_STATUS.exclude?(child["digitalStatus"].parameterize)
    end
    return [] if digital_objects.empty?

    digital_objects.map do |child|
      DigitalObject.new(
        pid: child["pid"],
        form: child["form"],
        bib_level: child["bibLevel"],
        title: child["title"],
        access_conditions: child["accessConditions"],
        digital_status: child["digitalStatus"],
        sensitive_material: child["sensitiveMaterial"],
        order: child["order"]
      )
    end
  end
end
