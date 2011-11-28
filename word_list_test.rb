require 'test/unit'
require './word_list.rb'

class WordListTest < Test::Unit::TestCase

  def setup
    @word_list = WordList.new
  end

  def test_word_list_is_initially_empty
    assert(@word_list.list.empty?)
  end

  def test_word_list_populates_from_file
    @word_list.load_from_file("test_words.txt")

    ["cat", "cats", "catsdogcats", "catxdogcatsrat",
     "dog", "dogcatsdog", "hippopotamuses",
     "rat", "ratcatdogcat"].each do |word|
      assert(@word_list.include?(word))
    end
  end

  def test_word_list_can_remove_words
    @word_list.load_from_file("test_words.txt")

    @word_list.remove("catxdogcatsrat")

    assert_equal(false, @word_list.include?("catxdogcatsrat"))
  end

  def test_longest_concatenated_word_from_list
    @word_list.load_from_file("test_words.txt")
    assert_equal("ratcatdogcat", @word_list.longest_concat_word)
  end

  def test_total_num_of_concats
    @word_list.load_from_file("test_words.txt")
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

  def test_second_longest_concat_word
    @word_list.remove("ethylenediaminetetraacetates")
    assert_equal("electroencephalographically", @word_list.longest_concat_word)
  end

  #Warning: Takes a long time to run (~83min)
   def test_total_num_of_concats
     assert_equal(97107, @word_list.num_of_concats)
   end

end
