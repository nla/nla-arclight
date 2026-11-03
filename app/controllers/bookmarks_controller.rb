# frozen_string_literal: true

class BookmarksController < CatalogController
  include Blacklight::Bookmarks

  def action_documents
    bookmark_ids = token_or_current_or_guest_user.bookmarks.pluck(:document_id).map(&:to_s)
    return [] if bookmark_ids.empty?

    search_service.fetch(bookmark_ids, rows: bookmark_ids.length)
  end

  # Copy every bookmarked finding aid in the selected citation style,
  # regardless of pagination.
  def cite_all
    @citation_style = params[:style].to_s
    return head :bad_request unless CitationHelper::CITATION_FORMATS.key?(@citation_style)

    @documents = action_documents
    render layout: !request.xhr?
  end

  # Export all bookmarked finding aids (regardless of pagination) as a
  # downloadable CSV or RIS file.
  def export
    @documents = action_documents

    respond_to do |format|
      format.csv do
        send_data Nla::Exports::CsvExport.new(@documents, export_fields, proc { |document| solr_document_url(document) }).render,
          filename: "bookmarks.csv", type: "text/csv", disposition: "attachment"
      end
      format.ris do
        send_data Nla::Exports::RisExport.new(@documents, proc { |document| solr_document_url(document) }).render,
          filename: "bookmarks.ris", type: "application/x-research-info-systems", disposition: "attachment"
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
