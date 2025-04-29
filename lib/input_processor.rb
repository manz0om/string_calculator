class InputProcessor
  def initialize(str = nil)
    @str = str
    @delimiters = [',']
  end

  def parse
    result = [@str]
    @delimiters.each do |de|
      result.each do |val|
        result = @str.split(de)
      end
      result.flatten!
    end
    result.map!{|i| i.to_i}
    result
  end
end