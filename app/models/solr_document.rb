# frozen_string_literal: true

# Represents a single document returned from Solr
class SolrDocument
  include Blacklight::Solr::Document
  include Arclight::SolrDocument

  # alias this field for the request link
  attribute :bibid, :string, "bibid_ssi"

  # self.unique_key = 'id'

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Document::SemanticFields#field_semantics
  # and Blacklight::Document::SemanticFields#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension(Blacklight::Document::DublinCore)

  def displayable?
    part?
  end

  def class?
    level&.parameterize == "class"
  end

  def series?
    level&.parameterize == "series"
  end

  def part?
    level&.parameterize == "part"
  end

  def item?
    level&.parameterize == "item"
  end

  def digital_objects
    digital_objects = []
    fav = EadService.findingaid(first("objid_ssm"))
    fav["children"]["manuscript"].each do |child|
      digital_objects << Arclight::DigitalObject.new(label: child["subUnitType"], href: ENV["REPRESENTATIVE_IMAGE_URL"] % child["pid"])
    end
    digital_objects.presence
  end
end
