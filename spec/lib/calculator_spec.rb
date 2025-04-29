require 'spec_helper'
require_relative '../../lib/calculator'

RSpec.describe Calculator do
  subject(:calculator) { Calculator.new }
  let(:numbers) {[]}
  context "add" do
    it "return 0 for empty inputs" do
      expect(subject.add(numbers)).to eq(0)
    end

    it "return sum for single input" do
      numbers = [1]
      expect(subject.add(numbers)).to eq(1)
    end

    it "return sum for two inputs" do
      numbers = [1,5]
      expect(subject.add(numbers)).to eq(6)
    end

    it "return sum for more than two inputs" do
      numbers = [1,5,1]
      expect(subject.add(numbers)).to eq(7)
    end

    it "return sum of numbers less than equal to 1000" do
      numbers = [1,5,1000,1001]
      expect(subject.add(numbers)).to eq(1006)
    end

    it "raise NegativeInputError for negative input" do
      numbers = [3,5,-1,-2]
      expect{ subject.add(numbers) }.to raise_error(NegativeInputError, "negative numbers not allowed -1,-2")
    end
  end
end