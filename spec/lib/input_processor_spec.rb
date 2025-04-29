require_relative '../../lib/input_processor'

RSpec.describe InputProcessor do
  subject { InputProcessor }
  let(:input) {""}
  context "process comma seperated input string" do
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
end