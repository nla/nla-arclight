# frozen_string_literal: true

class EmbedComponent < ViewComponent::Base
  def initialize(document:, presenter:, **kwargs)
    super

    @document = document
    @presenter = presenter
  end

  def render?
    resources.any?
  end

  def embeddable_resources
    resources.select { |resource| embeddable?(resource) }
  end

  def linked_resources
    resources - embeddable_resources
  end

  def resources
    @resources ||= @document.digital_objects || []
  end

  def depth
    @document.parents.length || 0
  end

  def embeddable?(object)
    object.displayable?
  end

  def exclude_patterns
    @exclude_patterns ||= @presenter.exclude_patterns
  end
end
