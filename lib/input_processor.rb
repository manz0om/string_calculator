# convert input to operable form
class InputProcessor
  def initialize(str = nil)
    @str = str
    @delimiters = [",","\\n","\n"]
    check_and_update_delimiters
  end

  def check_and_update_delimiters
    delimiter_substring = @str.match(%r{//(.*)\]\\n})
    if delimiter_substring
      delim_str_list = delimiter_substring[1].split(/\[|\]/)
      delim_str_list.delete("")
      @delimiters += delim_str_list
      @str = @str.split(%r{//(.*)\]\\n}).last
    end
    @delimiters
  end

  def parse
    result = [@str]
    @delimiters.each do |de|
      result.each_with_index do |val, i|
        result[i] = val.split(de)
        result[i].delete("")
      end
      result.flatten!
    end
    result.map!{|i| i.to_i}
    result
  end
end
