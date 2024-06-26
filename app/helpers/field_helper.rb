module FieldHelper
  def render_related_docs(document:, field:, config:, value:, context:)
    if document.pid.present?
      render RelatedDocumentsComponent.new(related_docs: value)
    end
  end
end
