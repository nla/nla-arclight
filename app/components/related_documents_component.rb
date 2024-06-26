# frozen_string_literal: true

class RelatedDocumentsComponent < Blacklight::Component
  attr_reader :related_docs

  def initialize(related_docs:)
    @related_docs = related_docs
  end

  def render?
    related_docs.present?
  end
end
