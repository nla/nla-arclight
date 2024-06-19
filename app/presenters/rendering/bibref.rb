# frozen_string_literal: true

module Rendering
  class Bibref < Blacklight::Rendering::AbstractStep
    def render
      next_step(render_bibref)
    end

    private

    def render_bibref
      fragment = Nokogiri::HTML::DocumentFragment.parse("")

      Nokogiri::HTML::Builder.with(fragment) do |doc|
        doc.h4 {
          doc.text I18n.t("ead_notes.bibref")
        }

        doc.ul(class: "list-unstyled") {
          # Sometimes the value is a single string instead of an array of strings
          Array.wrap(values).each do |value|
            doc.li do |list_item|
              list_item << value
            end
          end
        }
      end

      fragment.to_html
    end
  end
end
