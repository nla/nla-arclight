require "simplecov-html"
require "simplecov_json_formatter"

SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::JSONFormatter
])

SimpleCov.start "rails" do
  enable_coverage :branch

  add_filter do |source_file|
    source_file.lines.count < 10
  end

  # Generated/installed by Blacklight/Arclight.
  # CatalogueController is mostly config.
  # If any custom code is added to these classes, they should be removed from this filter and
  # tested.
  add_filter "app/controllers/catalog_controller.rb"
  add_filter "app/models/search_builder.rb"

  # filter out files that were overridden from Arclight/Blacklight for styling purposes
  add_filter "app/components/blacklight/start_over_button_component.rb"
  add_filter "app/components/blacklight/top_navbar_component.rb"
  add_filter "app/controllers/concerns/blacklight/bookmarks.rb"

  # Only returns style classes
  add_filter "app/helpers/layout_helper.rb"

  add_group "Components", "app/components"
  add_group "Presenters", "app/presenters"
end
