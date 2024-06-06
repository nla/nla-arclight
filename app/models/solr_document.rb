# frozen_string_literal: true

# Represents a single document returned from Solr
class SolrDocument
  include Blacklight::Solr::Document
  include Arclight::SolrDocument

  # alias this field for the request link
  attribute :bibid, :string, "bibid_ssi"
  attribute :physdesc_quantity, :string, "physdesc_quantity_ssi"
  attribute :physdesc_unittype, :string, "physdesc_unittype_ssi"
  attribute :physdesc_dimensions, :string, "physdesc_dimensions_ssi"
  attribute :physdesc_facet, :string, "physdesc_facet_ssi"
  attribute :notes, :array, "note_json_ssm"

  # **** BEWARE! ****
  # Arclight aliases "level_ssm" and "unitid_ssm" fields to String type attributes in the
  # Arclight::SolrDocument concern. This means, if there are multiple values for these fields,
  # calling the attribute alias will only return the first value.
  # MAKE SURE YOU'RE NOT LOSING DATA BY CALLING THE ALIAS INSTEAD OF DIRECTLY ACCESSING THE FIELD!

  # self.unique_key = 'id'

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Document::SemanticFields#field_semantics
  # and Blacklight::Document::SemanticFields#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension(Blacklight::Document::DublinCore)

  def collection_identifier
    [self["level_ssm"]&.join(" "), self["unitid_ssm"]&.join(" ")].compact.join(" ")
  end

  def extents_information
    quantity_unittype = [
      physdesc_quantity,
      physdesc_unittype
    ].compact.join(" ")

    dimensions_facet = [
      physdesc_dimensions,
      physdesc_facet
    ].compact.join(", ")

    if quantity_unittype.blank?
      dimensions_facet
    else
      [quantity_unittype, dimensions_facet].compact.join(", ")
    end
  end

  def extract_notes_by_header(header)
    # compares against the parameterized value of the header to ignore case and punctuation
    # rubocop:disable Rails/OutputSafety
    notes.select { |note| JSON.parse(note)["head"].parameterize == I18n.t("ead_notes.#{header}").parameterize }
      .map { |note| JSON.parse(note)["p"] }
      .flatten
      .map { |para| "<p>#{para}</p>".html_safe }
    # rubocop:enable Rails/OutputSafety
  end
end
