# frozen_string_literal: true

require "rails_helper"

RSpec.describe Arclight::BreadcrumbComponent, type: :component do
  let(:document) do
    SolrDocument.new(
      parent_ids_ssim: %w[abc123 abc123_def abc123_ghi],
      parent_unittitles_ssm: %w[ABC123 DEF GHI],
      ead_ssi: "abc123",
      repository_ssm: "my repository",
      _root_: "abc123"
    )
  end

  let(:render) do
    component.render_in(vc_test_controller.view_context)
  end

  let(:rendered) do
    Capybara::Node::Simple.new(render)
  end

  let(:component) { described_class.new(document: document) }

  context "with a count" do
    it "renders only that many breadcrumb links" do
      expect(rendered).to have_css "li", text: "my repository"
      expect(rendered).to have_link "ABC123", href: "/catalog/abc123"
      expect(rendered).not_to have_link "DEF", href: "/catalog/abc123_def"
      expect(rendered).not_to have_link "GHI", href: "/catalog/abc123_ghi"
    end

    it "renders an ellipsis if there are more links than the count" do
      expect(render).to end_with ">&hellip;</li></ol>"
    end
  end

  context "with an offset" do
    let(:attr) { {offset: 2} }

    it "skips some breadcrumb links" do
      expect(rendered).not_to have_css "li", text: "my repository"
      expect(rendered).not_to have_link "ABC123", href: "/catalog/abc123"
      expect(rendered).to have_link "DEF", href: "/catalog/abc123_def"
      expect(rendered).to have_link "GHI", href: "/catalog/abc123_ghi"
    end
  end

  it "renders breadcrumb links" do
    expect(rendered).to have_css "li", text: "my repository"
    expect(rendered).to have_link "DEF", href: "/catalog/abc123_def"
    expect(rendered).to have_link "GHI", href: "/catalog/abc123_ghi"
  end

  context "with legacy parent_ssm data" do
    let(:legacy_document) do
      SolrDocument.new(
        parent_ssim: %w[abc123 def ghi],
        parent_unittitles_ssm: %w[ABC123 DEF GHI],
        ead_ssi: "abc123",
        repository_ssm: "my repository",
        _root_: "abc123"
      )
    end

    let(:component) { described_class.new(document: legacy_document, **attr) }

    it "renders breadcrumb links" do
      expect(rendered).to have_link "DEF", href: "/catalog/abc123def"
      expect(rendered).to have_link "GHI", href: "/catalog/abc123ghi"
    end
  end
end
