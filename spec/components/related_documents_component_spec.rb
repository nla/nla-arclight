# frozen_string_literal: true

require "rails_helper"

RSpec.describe RelatedDocumentsComponent, type: :component do
  let(:pid) { "nla.obj-123" }

  let(:related_docs) do
    docs = JSON.parse(IO.read("spec/files/catalogue_services/related_docs.json"))["docs"]
    docs.map! do |attrs|
      attrs[:pid] = pid
      RelatedDocument.new(attrs)
    end
  end

  context "when there are no related documents" do
    it "does not render when there are no related documents" do
      render_inline(described_class.new(related_docs: nil))

      expect(page).to have_no_css("ol#related-documents")
    end
  end

  context "when there are related document" do
    it "renders the related documents" do
      render_inline(described_class.new(related_docs: related_docs(pid)))

      expect(page).to have_css("ol#related-documents")
      expect(page).to have_css("li", count: 4)
    end
  end

  context "when there are external comments" do
    it "renders the external comments" do
      render_inline(described_class.new(related_docs: related_docs(pid)))

      expect(page).to have_content("Appendix C - Items in Series 12.1")
    end
  end

  private

  def related_docs(pid)
    docs = JSON.parse(IO.read("spec/files/catalogue_services/related_docs.json"))["docs"]
    docs.map! do |attrs|
      attrs[:pid] = pid # insert the pid since we need it to construct the download URL
      RelatedDocument.new(attrs)
    end
  end
end
