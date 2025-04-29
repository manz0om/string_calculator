require 'spec_helper'
require_relative '../../lib/input_processor'

RSpec.describe InputProcessor do
  subject { InputProcessor }

  context "process comma seperated input string" do
    let(:input) {""}

    it "should parse string and return empty array" do
      expect(subject.new(input).parse).to eq([])
    end

    it "should parse string and return array with single number" do
      input = "1"
      expect(subject.new(input).parse).to eq([1])
    end

    it "should parse string and return array two numbers" do
      input = "1,5"
      expect(subject.new(input).parse).to eq([1,5])
    end

    it "should parse string and return array of numbers" do
      input = "1,5,1"
      expect(subject.new(input).parse).to eq([1,5,1])
    end

    it "should parse string and return array of numbers including negatives" do
      input = "3,5,-1,-2"
      expect(subject.new(input).parse).to eq([3,5,-1,-2])
    end
  end

  context "process \\n seperated input string" do
    let(:input) {"1\n2,3"}

    it "should parse string and return array of numbers" do
      expect(subject.new(input).parse).to eq([1,2,3])
    end

    it "should parse string with multiple \\n and return array of numbers" do
      input = "1\n\n\n2,\n3"
      expect(subject.new(input).parse).to eq([1,2,3])
    end

    it "should parse string with multiple \\n and return array of numbers including negatives" do
      input = "1\n\n\n2,\n3\n-6"
      expect(subject.new(input).parse).to eq([1,2,3,-6])
    end
  end

  context "process delimiter given in input string" do
    let(:input) {"//[***]\n1***2***3"}

    it "should parse string and return array of numbers" do
      expect(subject.new(input).parse).to eq([1,2,3])
    end

    it "should parse string and return array of numbers including negatives" do
      input = "//[***]\n1***2***3***-4"
      expect(subject.new(input).parse).to eq([1,2,3,-4])
    end
  end

  context "process mutiple delimiter given in input string" do
    let(:input) {"//[**][\\n][%]\n1**2%3\n1"}

    it "should parse string and return array of numbers" do
      expect(subject.new(input).parse).to eq([1,2,3,1])
    end

    it "should parse string and return array of numbers including negatives" do
      input = "//[**][%][----]\n1**2%3\n1-----5"
      expect(subject.new(input).parse).to eq([1,2,3,1,-5])
    end
  end
end