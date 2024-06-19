# frozen_string_literal: true

require "rails_helper"

RSpec.describe Rendering::Bibref do
  include Capybara::RSpecMatchers
  let(:document) { instance_double(SolrDocument) }
  let(:context) { double }
  let(:options) { {} }

  describe "#render" do
    subject(:rendered) { Blacklight::Rendering::Pipeline.new(values, field_config, document, context, [described_class], options).render }

    let(:field_config) { Blacklight::Configuration::NullField.new }

    context "when the note has a single bibref string" do
      let(:note) { JSON.parse(IO.read("spec/files/notes/chronlist.json")) }
      let(:values) { note["bibref"] }

      it "renders the bibref" do
        expect(rendered).to have_css("h4", text: "Bibliographic Reference(s)")
        expect(rendered).to have_css("ul.list-unstyled")
        expect(rendered).to have_css("li", count: 1)
      end

      it "inserts the existing HTML" do
        expect(rendered).to include("Prehistory to Politics")
        expect(rendered).to have_link(href: "http://nla.gov.au/nla.cat-vn2823420")
      end
    end

    context "when the note has multiple bibref strings" do
      let(:note) { JSON.parse(IO.read("spec/files/notes/multiple_bibref.json")) }
      let(:values) { note["bibref"] }

      it "renders the bibref" do
        expect(rendered).to have_css("h4", text: "Bibliographic Reference(s)")
        expect(rendered).to have_css("ul.list-unstyled")
        expect(rendered).to have_css("li", count: 2)
      end

      it "inserts the existing HTML" do
        expect(rendered).to have_css("em", text: "Who's who in Australia")
      end
    end

    context "when the bibref contains a hash" do
      let(:note) { JSON.parse(IO.read("spec/files/notes/bibref_content.json")) }
      let(:values) { note["bibref"] }

      it "renders the bibref" do
        expect(rendered).to have_css("h4", text: "Bibliographic Reference(s)")
        expect(rendered).to have_css("ul.list-unstyled")
        expect(rendered).to have_css("li", count: 1)
      end

      it "inserts the existing HTML" do
        expect(rendered).to have_css("span.persname", text: "Sexton, Christopher")
      end
    end
  end
end
