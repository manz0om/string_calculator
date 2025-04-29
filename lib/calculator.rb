require_relative 'error/negative_input_error.rb'

class Calculator

  def add(numbers)
    sum = 0
    negatives = []
    numbers.each do |n|
      next if n > 1000
      if n < 0
        negatives << n
        next
      end
      sum += n
    end
    raise NegativeInputError.new(negatives) unless negatives.empty?
    return sum
  end
end