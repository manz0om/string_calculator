class NegativeInputError < StandardError
  def initialize(args = nil)
    @args = args
    super
  end

  def message
    "negative numbers not allowed #{@args.join(',')}"
  end
end