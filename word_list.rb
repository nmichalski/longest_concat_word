class WordList
  attr :list, :lookup_table

  def initialize
    @list = []
    @lookup_table = {}
  end

  def load_from_file(file)
    File.open(file) do |infile|
      while (line = infile.gets)
        @list << line.strip
      end
    end
  end

  def include?(word)
    @list.include?(word)
  end

  def longest_word
    sorted_list_by_length.first
  end

  def longest_concat_word
    list_by_length = sorted_list_by_length
    list_by_length.each do |word|
      return word if concat_can_form?(word, true)
    end
    nil
  end

private
  def sorted_list_by_length
    @list.sort{|a,b| b.length <=> a.length}
  end

  def concat_can_form?(word, first_call=false)
#    if @lookup_table.has_key?(word)
#      return @lookup_table[word]
#    end
    temp_list = @list.dup
    temp_list.delete(word) if first_call

    word.length.downto(1) do |num|
      if temp_list.include? word[0...num]
        if (num == word.length) ||
           (concat_can_form?(word[num...word.length]))
#          @lookup_table[word] = true
          return true
        end
      end
    end
#    @lookup_table[word] = false
    false
  end

#
# DEBUGGING METHOD
#
  def show_list
    puts @list.inspect
  end

end
