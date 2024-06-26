# frozen_string_literal: true

class RelatedDocument < OpenStruct
  def link_text
    if copyRole == "fas"
      "#{I18n.t("related_docs.link_text_fas")} (Type: #{fileType}, Size: #{ApplicationController.helpers.format_filesize(fileSize)})"
    else
      "#{I18n.t("related_docs.link_text")} ( Type: #{fileType}, Size: #{ApplicationController.helpers.format_filesize(fileSize)})"
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
