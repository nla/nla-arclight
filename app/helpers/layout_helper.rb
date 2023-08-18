module LayoutHelper
  include Blacklight::LayoutHelperBehavior

  def main_content_classes
    "col-md-8 col-lg-9"
  end

  def sidebar_classes
    "page-sidebar col-md-4 col-lg-3"
  end
end
