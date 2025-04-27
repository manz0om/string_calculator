require_relative '../../lib/calculator'

RSpec.describe Calculator do
  subject(:calculator) { Calculator.new }

  context "add" do
    it "return 0 for empty inputs" do
      expect(subject.add([])).to eq(0)
    end

    it "return sum for single input" do
      expect(subject.add([1,5])).to eq(6)
    end

    it "return sum for two inputs" do
      expect(subject.add([1,5])).to eq(6)
    end

    it "return sum for more than two inputs" do
      expect(subject.add([1,5,1])).to eq(7)
    end

    it "raise NegativeInputError for negative input" do
      expect{ subject.add([3,5,-1,-2]) }.to raise_error(NegativeInputError, "negative numbers not allowed -1,-2")
    end
  end
end