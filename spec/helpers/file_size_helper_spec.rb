# frozen_string_literal: true

require "rails_helper"

RSpec.describe FileSizeHelper do
  describe "#format_filesize" do
    it "returns 0 when there is no file size" do
      expect(helper.format_filesize(nil)).to eq("0 B")
    end

    it "returns the size in kilobytes" do
      expect(helper.format_filesize(1024)).to eq("1.0 KB")
    end

    it "returns the size in megabytes" do
      expect(helper.format_filesize(1024 * 1024)).to eq("1.0 MB")
    end

    it "returns the size in gigabytes" do
      expect(helper.format_filesize(1024 * 1024 * 1024)).to eq("1.0 GB")
    end

    it "returns sizes 1 TB or larger in gigabytes" do
      expect(helper.format_filesize(1024 * 1024 * 1024 * 1024)).to eq("1024.0 GB")
    end

    it "rounds to the nearest 2 decimal places" do
      expect(helper.format_filesize(124305)).to eq("121.39 KB")
    end
  end
end
