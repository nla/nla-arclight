# frozen_string_literal: true

class DigitalObject
  attr_reader :pid, :form, :bib_level, :title, :access_conditions, :digital_status, :sensitive_material, :order

  def initialize(pid:, form:, bib_level:, title:, access_conditions:, digital_status:, sensitive_material:, order:)
    @pid = pid
    @form = form
    @bib_level = bib_level
    @title = title || pid
    @access_conditions = access_conditions
    @digital_status = digital_status
    @sensitive_material = sensitive_material
    @order = order
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
      order: @order
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
end
