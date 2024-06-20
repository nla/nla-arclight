# frozen_string_literal: true

module Rendering
  class Chronlist < Blacklight::Rendering::AbstractStep
    DEFAULT_HEADERS = %w[Date Event]

    def render
      next_step(render_chronlist)
    end

    private

    def render_chronlist
      col_headers = []
      if values["listhead"].present?
        values["listhead"].each { |header| col_headers << header[1] }
      else
        col_headers = DEFAULT_HEADERS
      end

      fragment = Nokogiri::HTML::DocumentFragment.parse("")

      Nokogiri::HTML::Builder.with(fragment) do |doc|
        if values["head"].present?
          doc.h4 {
            doc.text values["head"]
          }
        end

        doc.table(class: "table table-light table-responsive table-striped table-hover") do
          doc.thead(class: "table-purple") {
            doc.tr {
              col_headers.each do |header|
                doc.th {
                  doc.text header
                }
              end
            }
          }

          doc.tbody(class: "table-group-divider") {
            values["chronitem"].map! do |item|
              doc.tr {
                doc.td(class: "text-nowrap") {
                  # sometimes the value contains a calendar element
                  if item["date"].is_a?(Hash)
                    doc.text item["date"]["content"]
                  else
                    doc.text item["date"]
                  end
                }

                if item["eventgrp"].present?
                  doc.td {
                    doc.ul(class: "list-unstyled") {
                      Array.wrap(item["eventgrp"]["event"]).map! do |event|
                        doc.li do |list_item|
                          list_item << event
                        end
                      end
                    }
                  }
                else
                  doc.td {
                    doc.text item["event"]
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
