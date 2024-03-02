# frozen_string_literal: true

class DigitalObject
  include Rails.application.routes.url_helpers

  attr_reader :pid, :form, :bib_level, :title, :access_conditions, :digital_status, :sensitive_material, :order, :href

  BIB_LEVEL_ITEM = "item"
  DIGITAL_STATUS_CAPTURED = "captured"
  DIGITAL_STATUS_PARTIALLY_CAPTURED = "partially-captured"
  ACCESS_UNRESTRICTED = "unrestricted"
  NOT_SENSITIVE = "no"
  FORM_MANUSCRIPT = "manuscript"

  HREF_PATTERN = "https://nla.gov.au%s"

  def initialize(pid:, form:, bib_level:, title:, access_conditions:, digital_status:, sensitive_material:, order:)
    @pid = pid
    @form = form.parameterize
    @bib_level = bib_level.parameterize
    @title = title.parameterize || pid
    @access_conditions = access_conditions.parameterize
    @digital_status = digital_status.parameterize
    @sensitive_material = sensitive_material.parameterize
    @order = order

    # if displayable, link to the image, otherwise link to Trove Discovery
    @href = if displayable?
      representative_image_url(id: pid, only_path: true)
      # HREF_PATTERN % ["/#{pid}/image"]
    else
      HREF_PATTERN % ["/#{pid}"]
    end
  end

  def as_json(options = {})
    {
      pid: @pid,
      form: @form,
      bib_level: @bib_level,
      title: @title,
      access_conditions: @access_conditions,
      digital_status: @digital_status,
      sensitive_material: @sensitive_material,
      order: @order,
      href: @href
    }
  end

  def to_json(*)
    as_json.to_json(*)
  end

  def self.from_json(json)
    object_data = JSON.parse(json)
    new(
      pid: object_data["pid"],
      form: object_data["form"],
      bib_level: object_data["bib_level"],
      title: object_data["title"],
      access_conditions: object_data["access_conditions"],
      digital_status: object_data["digital_status"],
      sensitive_material: object_data["sensitive_material"],
      order: object_data["order"]
    )
  end

  def ==(other)
    pid == other.pid
  end

  def displayable?
    bib_level == BIB_LEVEL_ITEM &&
      form == FORM_MANUSCRIPT &&
      access_conditions == ACCESS_UNRESTRICTED &&
      sensitive_material == NOT_SENSITIVE
  end
end
