require 'spec_helper'
require 'open3'

RSpec.describe "String Calculator" do
  subject { File.expand_path("../../../bin/calculator.rb",__FILE__) }
  context "comma seperated string inputs" do
    it "empty input, returns 0" do
      stdin_data = <<~INPUT
        
      INPUT
      stdout_str, status = Open3.capture2('ruby', subject, stdin_data: stdin_data)

      expect(stdout_str).to include("sum of given input string is 0")
      expect(status.success?).to eq(true)
    end

    it "single string input, returns sum" do
      stdin_data = <<~INPUT
        1
      INPUT
      stdout_str, status = Open3.capture2('ruby',subject, stdin_data: stdin_data)

      expect(stdout_str).to include("sum of given input string is 1")
      expect(status.success?).to eq(true)
    end

    it "two number string input, returns sum" do
      stdin_data = <<~INPUT
        1,5
      INPUT
      stdout_str, status = Open3.capture2('ruby', subject, stdin_data: stdin_data)

      expect(stdout_str).to include("sum of given input string is 6")
      expect(status.success?).to eq(true)
    end

    it "multiple number string input, returns sum" do
      stdin_data = <<~INPUT
        1,5,1
      INPUT
      stdout_str, status = Open3.capture2('ruby', subject, stdin_data: stdin_data)

      expect(stdout_str).to include("sum of given input string is 7")
      expect(status.success?).to eq(true)
    end

    it "multiple number with negative string input, prints negative not allowed" do
      stdin_data = <<~INPUT
        3,5,-1,-2
      INPUT
      stdout_str, status = Open3.capture2('ruby', subject, stdin_data: stdin_data)

      expect(stdout_str).to include("negative numbers not allowed -1,-2")
      expect(status.success?).to eq(true)
    end
  end

  context "process \\n seperated input string" do
    it "should parse string and return the sum" do
      stdin_data = <<~INPUT
        1\\n2,3
      INPUT
      stdout_str, status = Open3.capture2('ruby', subject, stdin_data: stdin_data)

      expect(stdout_str).to include("sum of given input string is 6")
      expect(status.success?).to eq(true)
    end

    it "should parse string with multiple \\n and return array of numbers" do
      stdin_data = <<~INPUT
        1\\n\\n\\n2,\\n3
      INPUT
      stdout_str, status = Open3.capture2('ruby', subject, stdin_data: stdin_data)

      expect(stdout_str).to include("sum of given input string is 6")
      expect(status.success?).to eq(true)
    end

    it "should parse string with multiple \\n and display negative numbers not allowed" do
      stdin_data = <<~INPUT
        1\\n\\n\\n2,\\n3\\n-6
      INPUT
      stdout_str, status = Open3.capture2('ruby', subject, stdin_data: stdin_data)

      expect(stdout_str).to include("negative numbers not allowed -6")
      expect(status.success?).to eq(true)
    end
  end

  context "process delimiter given in input string" do
    it "should parse string and return array of numbers" do
      stdin_data = <<~INPUT
        "//[***]\n1***2***3"
      INPUT
      stdout_str, status = Open3.capture2('ruby', subject, stdin_data: stdin_data)

      expect(stdout_str).to include("sum of given input string is 6")
      expect(status.success?).to eq(true)
    end

    it "should parse string and display negative numbers not allowed" do
      stdin_data = <<~INPUT
        //[***]\n1***2***3***-4
      INPUT
      stdout_str, status = Open3.capture2('ruby', subject, stdin_data: stdin_data)

      expect(stdout_str).to include("negative numbers not allowed -4")
      expect(status.success?).to eq(true)
    end
  end

  context "process mutiple delimiter given in input string" do
    it "should parse string and return array of numbers" do
      stdin_data = <<~INPUT
        //[**][\\n][%]\n1**2%3\n1
      INPUT
      stdout_str, status = Open3.capture2('ruby', subject, stdin_data: stdin_data)

      expect(stdout_str).to include("sum of given input string is 7")
      expect(status.success?).to eq(true)
    end

    it "should parse string and display negative numbers not allowed" do
      stdin_data = <<~INPUT
        //[**][%][----]\n1**2%3\n1-----5
      INPUT
      stdout_str, status = Open3.capture2('ruby', subject, stdin_data: stdin_data)

      expect(stdout_str).to include("negative numbers not allowed -5")
      expect(status.success?).to eq(true)
    end
  end
end