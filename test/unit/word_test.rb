require File.dirname(__FILE__)/'..'/'test_helper'

class WordTest < Test::Unit::TestCase
  def test_simple_instantiation
    content = "foobar"
    test = Word.new(content)
    assert_equal(content, test)
  end
  
  def test_multiword_instantiation
    assert_raise(Word::FormatException) do
      Word.new("This has spaces.")
    end
  end
end