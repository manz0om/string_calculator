#!/usr/bin/env ruby

require_relative '../lib/input_processor'
require_relative '../lib/calculator'
require_relative '../lib/error/negative_input_error'

puts '------> String calculator <------'
puts "Enter String -: (press ctrl+Z(Windows) / ctrl+D(LINUX) to end the input)"
input = STDIN.read
input.gsub!("\n","\\n")
begin
  number_list = InputProcessor.new(input).parse
  sum = Calculator.new.add(number_list)
  puts "sum of given input string is #{sum}"
rescue NegativeInputError => e
  puts e.message
end
