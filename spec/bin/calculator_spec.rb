require 'spec_helper'
require 'open3'

RSpec.describe "String Calculator" do
  subject { File.expand_path("../../../bin/calculator.rb",__FILE__) }
  context "comma seperated string inputs" do
    it "empty input, returns 0" do
      stdin_data = <<~INPUT

        e
      INPUT
      stdout_str, status = Open3.capture2('ruby', subject, stdin_data: stdin_data)

      expect(stdout_str).to include("sum of given input string is 0")
      expect(status.success?).to eq(true)
    end

    it "single string input, returns sum" do
      stdin_data = <<~INPUT
        1
        e
      INPUT
      stdout_str, status = Open3.capture2('ruby',subject, stdin_data: stdin_data)

      expect(stdout_str).to include("sum of given input string is 1")
      expect(status.success?).to eq(true)
    end

    it "two number string input, returns sum" do
      stdin_data = <<~INPUT
        1,5
        e
      INPUT
      stdout_str, status = Open3.capture2('ruby', subject, stdin_data: stdin_data)

      expect(stdout_str).to include("sum of given input string is 6")
      expect(status.success?).to eq(true)
    end

    it "multiple number string input, returns sum" do
      stdin_data = <<~INPUT
        1,5,1
        e
      INPUT
      stdout_str, status = Open3.capture2('ruby', subject, stdin_data: stdin_data)

      expect(stdout_str).to include("sum of given input string is 7")
      expect(status.success?).to eq(true)
    end

    it "multiple number with negative string input, prints negative not allowed" do
      stdin_data = <<~INPUT
        3,5,-1,-2
        e
      INPUT
      stdout_str, status = Open3.capture2('ruby', subject, stdin_data: stdin_data)

      expect(stdout_str).to include("negative numbers not allowed -1,-2")
      expect(status.success?).to eq(true)
    end
  end
end