# frozen_string_literal: true

class BookmarksController < CatalogController
  include Blacklight::Bookmarks

  def action_documents
    return [] if token_or_current_or_guest_user.bookmarks.empty?

    super
  end

  # Modal listing every bookmarked finding aid (all bookmarks in the
  # account, regardless of pagination) with the fields displayed in the
  # bookmarks view, plus data-doc-id and the record URL, which can be
  # copied to the clipboard in one action.
  def cite_all
    @documents = action_documents
  end

  # Export all bookmarked finding aids (regardless of pagination) as a
  # downloadable CSV file.
  def export
    @documents = action_documents

    respond_to do |format|
      format.csv do
        send_data Nla::Exports::CsvExport.new(@documents, export_fields, proc { |document| solr_document_url(document) }).render,
          filename: "bookmarks.csv", type: "text/csv", disposition: "attachment"
      end
    end
  end

  private

  # Fields displayed in the finding aids bookmarks view, in display order,
  # excluding the search-highlight snippet
  def export_fields
    CatalogController.blacklight_config.index_fields.to_h.except("highlight").values
  end

  # The gem's verify_user references the undefined #action method, which
  # raises a NameError for any action other than index
  def verify_user
    return if current_or_guest_user
    return if params[:action] == "index" && token_or_current_or_guest_user

    flash[:notice] = I18n.t("blacklight.bookmarks.need_login")
    raise Blacklight::Exceptions::AccessDenied
  end
end
