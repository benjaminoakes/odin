require 'test/unit'
require File.dirname(__FILE__) + '/augmented_transition_network'

class AugmentedTransitionNetworkTest < Test::Unit::TestCase
  def setup
    @atn = AugmentedTransitionNetwork.new
  end
  
  def test_non_passive_parse
    sentences = []
    sentences << %w{man grows}
    sentences << %w{the man grows}
    sentences << %w{the old man grows}
    sentences << %w{the old smiling man grows}
    sentences << %w{the old smiling man grows avocados}
    sentences << %w{the old smiling man grows the avocados}
    sentences << %w{the old old smiling man grows the avocados}
    sentences << %w{monster ate}
    sentences << %w{the monster ate}
    sentences << %w{the monster ate cookie}
    sentences << %w{the monster ate the cookie}
    sentences << %w{the monster ate the old cookie}
    
    sentences.each do |sentence|
      parsed = @atn.parse_to_string(sentence)
      # puts("sentence: #{sentence.inspect}")
      # puts("parsed: #{parsed.inspect}")
      # puts('=' * 50)
      # puts @atn.parse(sentence).inspect_as_tree
      # puts('=' * 50)
      assert_equal(sentence.join(" "), parsed)
    end
  end
  
  def test_passive_parse
    assert_equal("monster ate cookie", @atn.parse_to_string(%w{cookie was eaten by monster}))
    assert_equal("the monster ate the cookie", @atn.parse_to_string(%w{the cookie was eaten by the monster}))
    assert_equal("the monster ate the old cookie", @atn.parse_to_string(%w{the old cookie was eaten by the monster}))
    assert_equal("the avocados ate the old man", @atn.parse_to_string(%w{the old man was eaten by the avocados}))
    puts @atn.parse(%w{the old man was eaten by the avocados}).inspect_as_tree
  end
  
  def test_ungrammatical_parse
    ungrammatical = []
    ungrammatical << %w{the}
    ungrammatical << %w{man}
    ungrammatical << %w{the man}
    ungrammatical << %w{the old man}
    ungrammatical << %w{the old smiling man}
    ungrammatical << %w{grows}
    ungrammatical << %w{grows avocados}
    ungrammatical << %w{grows the avocados}
    ungrammatical << %w{was the avocados}
    ungrammatical << %w{was eaten the avocados}
    ungrammatical << %w{was eaten by the avocados}
    # ungrammatical << %w{the old man was eaten the avocados}
    
    ungrammatical.each do |sentence|
      assert_raise(Ungrammatical) do
        @atn.parse(sentence)
      end
    end
  end
  
  def test_prepositional_phrase
    assert_equal("in the street", @atn.parse_to_string(%w{in the street}, :prepositional_phrase))
    
    ungrammatical = []
    ungrammatical << %w{}
    ungrammatical << %w{in}
    ungrammatical << %w{in the}
    ungrammatical << %w{in the the}
    ungrammatical << %w{in the grows}
    
    ungrammatical.each do |phrase|
      assert_raise(Ungrammatical) do
        @atn.parse(phrase, :prepositional_phrase)
      end
    end
  end
  
  def test_prepositional_phrase_in_noun_phrase
    assert_equal("man in street", @atn.parse_to_string(%w{man in street}, :noun_phrase))
    assert_equal("man in the street", @atn.parse_to_string(%w{man in the street}, :noun_phrase))
    assert_equal("the man in the street", @atn.parse_to_string(%w{the man in the street}, :noun_phrase))
  end
  
  def test_prepositional_phrase_in_sentence
    assert_equal("man in street grows", @atn.parse_to_string(%w{man in street grows}))
    assert_equal("man in the street grows", @atn.parse_to_string(%w{man in the street grows}))
    assert_equal("the man in the street grows", @atn.parse_to_string(%w{the man in the street grows}))
    assert_equal("the man in the street grows avocados", @atn.parse_to_string(%w{the man in the street grows avocados}))
    
    assert_equal("the man grows avocados in the street", @atn.parse_to_string(%w{the man grows avocados in the street}))
    assert_equal("the man in the street grows avocados in the street", @atn.parse_to_string(%w{the man in the street grows avocados in the street}))
    
    ungrammatical = []
    ungrammatical << %w{}
    ungrammatical << %w{in}
    ungrammatical << %w{in the}
    ungrammatical << %w{in the the}
    ungrammatical << %w{in the grows}
    ungrammatical << %w{the in the street man in the street grows avocados in the street}
    
    ungrammatical.each do |phrase|
      assert_raise(Ungrammatical) do
        @atn.parse(phrase, :prepositional_phrase)
      end
    end
    
    # puts @atn.parse(%w{the monster in the man grows avocados in the street}).inspect
  end
end