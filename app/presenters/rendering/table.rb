# frozen_string_literal: true

module Rendering
  class Table < Blacklight::Rendering::AbstractStep
    def render
      next_step(render_table)
    end

    private

    def render_table
      fragment = Nokogiri::HTML::DocumentFragment.parse("")

      Nokogiri::HTML::Builder.with(fragment) do |doc|
        doc.table(class: "table table-light table-responsive table-striped table-hover") {
          doc.thead(class: "table-purple") {
            doc.tr {
              values["tgroup"]["thead"]["row"]["entry"].map! do |header|
                doc.th {
                  doc.text header
                }
              end
            }
          }

          doc.tbody(class: "table-group-divider") {
            values["tgroup"]["tbody"]["row"].map! do |row|
              doc.tr {
                row["entry"]&.map! do |entry|
                  doc.td {
                    doc.text entry
                  }
                end
              }
            end
          }
        }
      end

      fragment.to_html
    end
  end
end
