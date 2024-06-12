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

    extent_info = if quantity_unittype.blank?
      dimensions_facet
    else
      [quantity_unittype, dimensions_facet].compact.join(", ")
    end

    extent_info.presence
  end

  def extract_notes_by_header(header)
    filtered_notes = filter_notes_by_header(header)
    if filtered_notes.present?
      wrap_paragraphs_in_html(parse_note_paragraphs(filtered_notes))
    end
  end

  private

  def filter_notes_by_header(header)
    # compares against the parameterized value of the header to ignore case and punctuation
    notes.select { |note| JSON.parse(note)["head"].parameterize == I18n.t("ead_notes.#{header}").parameterize }
  end

  def parse_note_paragraphs(notes)
    # Sometimes note paragraphs are returned as a simple JSON string, and other times, as an array.
    # Ensure we always have an array by wrapping the paragraphs in an array, then flatten the array,
    # so we only return a single dimensional array of paragraphs.
    notes.map! { |note| [JSON.parse(note)["p"]] }
      .flatten!
  end

  def wrap_paragraphs_in_html(paragraphs)
    # Wraps note paragrphs in HTML `<p></p>` tags, then scrubs the HTML to remove any unknown or
    # unsafe tags.
    paragraphs.map! do |para|
      Loofah.xml_fragment(wrap_in_paragraph(para))
        .scrub!(:strip)
        .to_html
    end
  end

  def wrap_in_paragraph(value)
    if value.start_with?("<")
      value
    else
      ActionController::Base.helpers.content_tag(:p, value)
    end
  end
end
