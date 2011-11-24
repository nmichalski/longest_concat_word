require 'trie'

class WordList
  attr :list, :lookup_table, :trie, :count

  def initialize
    @list = []
    @lookup_table = {}
    @trie = Trie.new
    @count = 0
  end

  def load_from_file(file)
    File.open(file) do |infile|
      while (line = infile.gets)
        word = line.strip
        @list << word
        @trie.insert(word, word.length)
      end
    end
  end

  def include?(word)
    !@trie[word].empty?
  end

  def longest_concat_word
    sorted_list_by_length.each do |word|
      return word if concat_can_form?(word, true)
    end
    nil
  end

  def num_of_concats
    @count = 0
    sorted_list_by_length.each do |word|
      if concat_can_form?(word, true)
        @count += 1
        puts word
      end
    end
    @count
  end

private
  def sorted_list_by_length
    @list.sort{|a,b| b.length <=> a.length}
  end

  def concat_can_form?(word, first_call=false)
    if @lookup_table.has_key?(word)
      return @lookup_table[word]
    end

    @trie.delete_pair(word, word.length) if first_call

    word.length.downto(1) do |num|
      if !@trie[word[0...num]].empty?
        if (num == word.length) ||
           concat_can_form?(word[num...word.length])
          @lookup_table[word] = true if first_call
          @trie.insert(word, word.length) if first_call
          return true
        end
      end
    end

    @lookup_table[word] = false if first_call
    @trie.insert(word, word.length) if first_call
    false
  end

end
