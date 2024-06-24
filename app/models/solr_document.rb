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
    notes.map! { |note|
      json_note = JSON.parse(note)
      extracted_notes = Array.wrap(json_note["p"])
      if json_note["chronlist"].present?
        begin
          if json_note["chronlist"]["head"].present?
            extracted_notes += Array.wrap({chronlist: json_note["chronlist"]})
          end
        rescue
          Rails.logger.error { "Error parsing chronlist note for #{id}" }
        end
      end
      extracted_notes
    }.compact.flatten
  end

  def wrap_paragraphs_in_html(paragraphs)
    paragraphs.map! do |para|
      if para.is_a?(String)
        # Wraps note paragraphs in HTML `<p></p>` tags, then scrubs the HTML to remove any unknown or
        # unsafe tags.
        Loofah.xml_fragment(wrap_in_paragraph(para))
          .scrub!(:strip)
          .to_html
      elsif para.is_a?(Hash)
        # Turn the hash into JSON because it's easier to convert back into an object
        # than a string representation of a Hash.
        para.to_json
      end
    end
  end

  def wrap_in_paragraph(value)
    if value.start_with?("<")
      value
    else
      # rubocop:disable Rails/OutputSafety
      ActionController::Base.helpers.content_tag(:p, value.html_safe)
      # rubocop:enable Rails/OutputSafety
    end
  end

  def availability_status
    holdings, item = CatalogueServicesClient.new.get_item_ids(instance_id: self["folio_instance_id_ssi"])
    Rails.logger.debug "solrdoc availability status"
    Rails.logger.debug [holdings, item]

    CatalogueServicesClient.new.get_requestable(instance_id: self["folio_instance_id_ssi"], holdings_id: holdings, item_id: item)
  end

  def access_conditions
    holdings, item = CatalogueServicesClient.new.get_item_ids(instance_id: self["folio_instance_id_ssi"])
    Rails.logger.debug "solrdoc access conditions"
    Rails.logger.debug [holdings, item]
    CatalogueServicesClient.new.get_notes(instance_id: self["folio_instance_id_ssi"], holdings_id: holdings, item_id: item)
  end
end
