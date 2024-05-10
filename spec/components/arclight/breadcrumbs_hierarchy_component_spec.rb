# frozen_string_literal: true

require "rails_helper"

RSpec.describe BreadcrumbsHierarchyComponent, type: :component do
  let(:document) do
    SolrDocument.new(
      ead_ssi: "abc123",
      repository_ssm: "National Library of Australia",
      _root_: "abc123",
      normalized_title_ssm: "ABC123",
      level_ssm: "collection"
    )
  end
  let(:view_context) { ActionView::Base.new(nil, {}, nil) }
  let(:config) { Blacklight::Configuration.new }
  let(:show_presenter) { ShowPresenter.new(document, view_context, config) }

  context "when viewing collection" do
    it "renders collection title with prefix" do
      render_inline(described_class.new(presenter: show_presenter))

      expect(page).to have_css "li", text: "National Library of Australia"
      expect(page).to have_css "li", text: "Guide to the ABC123"
    end
  end

  context "when viewing series" do
    let(:document) do
      SolrDocument.new(
        parent_ssim: %w[abc123 abc123_def],
        parent_unittitles_ssm: %w[ABC123 DEF],
        parent_levels_ssm: %w[collection Series],
        ead_ssi: "abc123",
        repository_ssm: "National Library of Australia",
        _root_: "abc123",
        normalized_title_ssm: "GHI",
        level_ssm: "Subseries"
      )
    end

    it "renders series titles without prefix" do
      render_inline(described_class.new(presenter: show_presenter))

      expect(page).to have_css "li", text: "National Library of Australia"
      expect(page).to have_link "Guide to the ABC123", href: "/finding-aids/catalog/abc123"

      expect(page).to have_link "DEF", href: "/finding-aids/catalog/abc123abc123_def"
      expect(page).not_to have_link "Guide to the DEF", href: "/finding-aids/catalog/abc123abc123_def"

      expect(page).to have_css "li", text: "GHI"
      expect(page).not_to have_link "GHI", href: "/finding-aids/catalog/abc123abc123_ghi"
      expect(page).not_to have_link "Guide to the GHI", href: "/finding-aids/catalog/abc123abc123_ghi"
    end
  end

  context "when viewing file" do
    let(:document) do
      SolrDocument.new(
        parent_ssim: %w[abc123 abc123_def abc123_ghi],
        parent_unittitles_ssm: %w[ABC123 DEF GHI],
        parent_levels_ssm: %w[collection Series Subseries],
        ead_ssi: "abc123",
        repository_ssm: "National Library of Australia",
        _root_: "abc123",
        normalized_title_ssm: "JKL",
        level_ssm: "file"
      )
    end

    it "renders file titles without prefix" do
      render_inline(described_class.new(presenter: show_presenter))

      expect(page).to have_css "li", text: "National Library of Australia"
      expect(page).to have_link "Guide to the ABC123", href: "/finding-aids/catalog/abc123"

      expect(page).to have_link "DEF", href: "/finding-aids/catalog/abc123abc123_def"
      expect(page).not_to have_link "Guide to the DEF", href: "/finding-aids/catalog/abc123abc123_def"

      expect(page).to have_link "GHI", href: "/finding-aids/catalog/abc123abc123_ghi"
      expect(page).not_to have_link "Guide to the GHI", href: "/finding-aids/catalog/abc123abc123_ghi"

      expect(page).to have_css "li", text: "JKL"
      expect(page).not_to have_css "li", text: "Guide to the JKL"
      expect(page).not_to have_link "JKL"
    end
  end
end
