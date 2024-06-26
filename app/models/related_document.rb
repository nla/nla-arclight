# frozen_string_literal: true

class RelatedDocument < OpenStruct
  def initializer(attributes)
    super(to_ostruct(attributes))
  end

  def to_ostruct(object)
    case object
    when Hash
      OpenStruct.new(object.map { |key, value| [key.to_sym, value] }.to_h)
    when Array
      object.map! { |i| to_ostruct(i) }
    else # a primitive value
      object
    end
  end

  def link_text
    if copyRole == "fas"
      "#{I18n.t("related_docs.link_text_fas")} (Type: #{fileType}, Size: #{ApplicationController.helpers.format_filesize(fileSize)})"
    else
      "#{I18n.t("related_docs.link_text")} ( Type: #{fileType}, Size: #{ApplicationController.helpers.format_filesize.call(fileSize)})"
    end
  end

  def download_url
    if copyRole == "fas"
      "https://nla.gov.au/#{pid}/relateddocs/download?copyRole=#{copyRole}&copyId=#{id}"
    else
      "https://nla.gov.au/#{pid}/relateddocs/download?copyRole=#{copyRole}"
    end
  end
end
