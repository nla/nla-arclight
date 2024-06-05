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

  def availability_status
    # CatalogueServicesClient.new.get_holdings(instance_id: "9eb10dc5-5114-5cce-85a4-a29ed264b2c0")
    # CatalogueServicesClient.new.get_holdings(instance_id: self["folio_instance_id_ssi"])
    # holdings_id is itemRecords->holdingsRecordId
    # item_id is itemRecords->itemId
    # CatalogueServicesClient.new.get_requestable(instance_id: self["folio_instance_id_ssi"], holdings_id: "977765de-555a-5320-9748-a39595160323", item_id: "1cd986e5-e8de-5de3-817a-1ec57b7d8aa4")

    # CatalogueServicesClient.new.get_requestable(instance_id: self["folio_instance_id_ssi"], holdings_id: "6c22902a-424b-5bdc-a106-b07e084b651f", item_id: "b8f927b2-8f1e-56c0-af38-9fb6f145d8d5")

    holdings, item = CatalogueServicesClient.new.get_item_ids(instance_id: self["folio_instance_id_ssi"])
    p [item, holdings]

    CatalogueServicesClient.new.get_requestable(instance_id: self["folio_instance_id_ssi"], holdings_id: holdings, item_id: item)
  end

  # self.unique_key = 'id'

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Document::SemanticFields#field_semantics
  # and Blacklight::Document::SemanticFields#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension(Blacklight::Document::DublinCore)
end
