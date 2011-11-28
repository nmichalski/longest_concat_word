require 'trie'

class WordList
  attr_reader :list
  attr :lookup_table, :trie, :concat_count, :min_word_length

  def initialize
    @list = []
    @lookup_table = {}
    @trie = Trie.new
    @concat_count = 0
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

  def remove(word)
    if self.include?(word)
      @list.delete(word)
      @trie.delete_pair(word, word.length)
    end
  end

  def longest_concat_word
    sorted_list_by_length_dsc.each do |word|
      return word if concat_can_form?(word, true)
    end
    nil
  end

  def num_of_concats
    @concat_count = 0
    sorted_list_by_length_dsc.each do |word|
      if word.length >= (2 * min_word_length) &&
         concat_can_form?(word, true)
          @concat_count += 1
      end
    end
    @concat_count
  end

private
  def sorted_list_by_length_dsc
    @list.sort{|a,b| b.length <=> a.length}
  end

  #TODO: lookup_table is not helping how I'd like it to,
  #      it should short-circuit on shorter concatenated words
  def concat_can_form?(word, first_call=false)
    if @lookup_table.has_key?(word)
      return @lookup_table[word]
    end

    @trie.delete_pair(word, word.length) if first_call

    word.length.downto(1) do |num|
      if !@trie[word[0...num]].empty? #if substring is in trie
        if (num == word.length) || #and if entire word param is in trie or
           concat_can_form?(word[num...word.length]) #(substring and) remainder is in trie
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

  def min_word_length
    @min_word_length ||= @list.sort{|a,b| a.length <=> b.length}.first.length
  end

end
