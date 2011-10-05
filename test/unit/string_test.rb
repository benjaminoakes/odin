require File.dirname(__FILE__)/'..'/'test_helper'
require File.dirname(__FILE__)/'string_bracketing_test_module'

class StringTest < Test::Unit::TestCase
  include StringBracketingTests
  
  def setup  
    @test_sentences = []
    @test_sentences << @only_period_sentence = "This has no punctuation except for a period."
    @test_sentences << @contraction_sentence = "Shouldn't we also test with contractions?"
    @test_sentences << "Hello, John."
    @test_sentences << "How are you?"
    @test_sentences << "How are you?!"
    @test_sentences << "Hello, world!"
    @test_sentences << @ellipsis_and_apostrophe_sentence = "That's odd..."
    @test_sentences << "Program exited."
    @test_sentences << "Hey guys..."
    @test_sentences << "Looks good, the with_index is the option I was looking for..."
    @test_sentences << "just looked so messy having to declare a counter variable in a view..."
    @test_sentences << "thanks!"
    @test_sentences << "But a much cleaner solution would be to not test for whether the method was called but whether logged-out users can access the controller."
    @test_sentences << "Because what you're really trying to test is whether certain users can visit certain pages, right?"
    @test_sentences << "So just check for that."
    @test_sentences << "Then you can change the implementation (rename or replace the before filter) later and your tests won't break."
  end
  
  def test_minus
    assert_equal("fbar", "foobar" - "oo")
    assert_equal("pia pia!", "pizza pizza!" - "zz")
    assert_equal("", "letters" - /[a-z]+/)
  end
  
  def test_normalize
    assert_equal("hello, world.", "Hello, world!".normalize)
    assert_equal("how are you.", "How are you?".normalize)
    assert_equal("how are you.", "How are you?!".normalize)
    assert_equal("that's odd.", "That's odd...".normalize)
  end
  
  def test_each_sentence
    corpus = @test_sentences.join("  ")
    index = 0
    corpus.sentences.each do |sentence|
      assert_equal(@test_sentences[index], sentence)
      index += 1
    end
  end
  
  def test_no_words_in_empty_string
    assert_equal(0, "".words.length)
  end
  
  def test_no_words_in_whitespace_string
    assert_equal(0, " ".words.length)
    assert_equal(0, "  ".words.length)
    assert_equal(0, "                ".words.length)
    assert_equal(0, "\t".words.length)
  end
  
  def test_whitespace_then_character_string
    assert_equal(1, "                A".words.length)
    assert_equal(2, "                A B".words.length)
    assert_equal(2, "                A      B".words.length)
  end
    
  def test_words_in_a_sentence_with_no_punctuation
    no_punctuation_sentence = "This sentence does not even have a period"
    expected_words = ["This", "sentence", "does", "not", "even", "have", "a" ,"period"]
    assert_equal(expected_words, no_punctuation_sentence.words)
  end
  
  def test_words_in_a_sentence_with_only_a_period
    expected_words = ['This', 'has', 'no', 'punctuation', 'except', 'for', 'a', 'period']
    assert_equal(expected_words, @only_period_sentence.words)
  end
  
  def test_each_word_with_contraction
    expected_words = ['Shouldn\'t', 'we', 'also', 'test', 'with', 'contractions']
    assert_equal(expected_words, @contraction_sentence.words)
  end
  
  # "grammatical?" tested in atn_test.rb
  
  def test_check_grammar
    # TODO
    # output = "The old man loves you.  The man the apples.".check_grammar do |sentence|
    #   "<ungrammatical message=\"\" suggestion=\"\">#{sentence}</ungrammatical>"
    # end
    # 
    # puts output
  end
end