module FileSizeHelper
  def format_filesize(size)
    if size.present?
      if size.to_i < 1024
        "#{size} B"
      elsif size.to_i < 1048576 # 1024 * 1024
        "#{(size.to_f / 1024).round(2)} KB"
      elsif size.to_i < 1073741824 # 1024 * 1024 * 1024
        "#{(size.to_f / 1048576).round(2)} MB"
      else
        "#{(size.to_f / 1073741824).round(2)} GB"
      end
    else
      "0 B"
    end
  end
end
