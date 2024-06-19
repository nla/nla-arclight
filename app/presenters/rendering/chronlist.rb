# frozen_string_literal: true

module Rendering
  class Chronlist < Blacklight::Rendering::AbstractStep
    def render
      next_step(render_chronlist)
    end

    private

    def render_chronlist
      header_keys = []
      values["listhead"].each do |header|
        header_keys << header[1].downcase
      end

      fragment = Nokogiri::HTML::DocumentFragment.parse("")

      Nokogiri::HTML::Builder.with(fragment) do |doc|
        doc.table(class: "table table-light table-responsive table-striped table-hover") do
          doc.thead(class: "table-purple") {
            doc.tr {
              header_keys.each do |header|
                doc.th {
                  doc.text header.titleize
                }
              end
            }
          }

          doc.tbody(class: "table-group-divider") {
            values["chronitem"].map! do |item|
              doc.tr {
                header_keys.each do |key|
                  doc.td(class: (key == "date") ? "text-nowrap" : "") {
                    # sometimes the value contains a calendar element
                    if item[key].is_a?(Hash)
                      doc.text item[key]["content"]
                    else
                      doc.text item[key]
                    end
                  }
                end
              }
            end
          }
        end
      end

      fragment.to_html
    end
  end
end
