# frozen_string_literal: true

class SubnotesPresenter < Blacklight::FieldPresenter
  CHRONLIST_ELEMENT = "chronlist"
  BIBREF_ELEMENT = "bibref"
  TABLE_ELEMENT = "table"

  SUBNOTE_ELEMENTS = [
    CHRONLIST_ELEMENT, BIBREF_ELEMENT, TABLE_ELEMENT
  ]

  def render
    values.map! do |value|
      # Need to check if the value contains a subnote element (JSON), because in some cases,
      # it's embedded amongst paragraphs in the note and we don't need to render those separately.
      if valid_json?(value)
        render_subnote(value)
      else
        # Otherwise, render it normally
        value
      end
    end

    Blacklight::Rendering::Pipeline.new(values, field_config, document, view_context, pipeline_steps, options).render
  end

  private

  def render_subnote(value)
    subnote_value = JSON.parse(value)

    rendered_subnote = []

    # Order matters here!
    # If there are multiple subnotes that can appear in a single metadata section, they should be
    # rendered in order, since the generated HTML from each subnote is concatenated together to
    # form the whole note.

    if subnote_value.key? TABLE_ELEMENT
      rendered_subnote << Blacklight::Rendering::Pipeline.new(subnote_value[TABLE_ELEMENT], field_config, document, view_context, [Rendering::Table], options).render
    end

    if subnote_value.key? CHRONLIST_ELEMENT
      rendered_subnote << Blacklight::Rendering::Pipeline.new(subnote_value[CHRONLIST_ELEMENT], field_config, document, view_context, [Rendering::Chronlist], options).render
    end

    if subnote_value.key? BIBREF_ELEMENT
      rendered_subnote << Blacklight::Rendering::Pipeline.new(subnote_value[BIBREF_ELEMENT], field_config, document, view_context, [Rendering::Bibref], options).render
    end

    # everything else that's not a known subnote element will not be rendered

    rendered_subnote.compact.join
  end

  def valid_json?(value)
    JSON.parse(value)
    true
  rescue JSON::ParserError
    false
  end
end
