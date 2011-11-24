require 'test/unit'
require './word_list.rb'

class WordListTest < Test::Unit::TestCase

  def setup
    @word_list = WordList.new
    @word_list.load_from_file("test_words.txt")
  end

  def test_word_list_populates_from_file
    ["cat", "cats", "catsdogcats", "catxdogcatsrat",
     "dog", "dogcatsdog", "hippopotamuses",
     "rat", "ratcatdogcat"].each do |word|
      assert(@word_list.include?(word))
    end
  end

  def test_longest_concatenated_word_from_list
    assert_equal("ratcatdogcat", @word_list.longest_concat_word)
  end

  def test_total_num_of_concats
    assert_equal(3, @word_list.num_of_concats)
  end

end

class LongWordListTest < Test::Unit::TestCase

  def setup
    @word_list = WordList.new
    @word_list.load_from_file("words.txt")
  end

  def test_longest_concat_word
    assert_equal("ethylenediaminetetraacetates", @word_list.longest_concat_word)
  end

  #Warning: Takes a long time to run
  def test_total_num_of_concats
    puts @word_list.num_of_concats
  end

end
