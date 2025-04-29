#!/usr/bin/env ruby

require_relative '../lib/input_processor'
require_relative '../lib/calculator'
require_relative '../lib/error/negative_input_error'

puts '------> String calculator <------'

loop do
  puts "Enter String -:"
  input = gets.chomp
  begin
    number_list = InputProcessor.new(input).parse
    sum = Calculator.new.add(number_list)
    puts "sum of given input string is #{sum}"
  rescue NegativeInputError => e
    puts e.message
  end
  puts "\n\n"
  puts "Press e to exit or y to continue"
  input = gets.chomp
  break unless input.downcase == 'y'
end