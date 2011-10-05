require File.dirname(__FILE__) + '/string_bracketing.rb'
require File.dirname(__FILE__) + '/word.rb'

class String
  include StringBracketing
  
  @@ending_punctuation = /[.?!]+/
  
  alias :trim :strip
  
  def -(pattern)
    self.gsub(pattern, '')
  end
  
  def /(str_to_join)
    File.join(self, str_to_join)
  end
  
  def normalize
    # We use "." as a "full-stop" character that denotes the end of a sentence, regardless
    # "+" in the regex for sentences like "Hello again..." => "hello again."
    # TODO how is this used with abbreviations?
    self.downcase.gsub(/#{@@ending_punctuation}/, '.')
  end
  
  # TODO I would think that there might be some way of using Enumerable#inject to simplify these three
  
  def sentences
    sentences = []
    
    self.gsub(/.*?#{@@ending_punctuation}/i) do |match|
      sentences << match.trim
    end
    
    return sentences
  end
  
  def words
    # Not the most efficient, but it works better than the old one
    words = []
    
    self.split(/\s+/).each do |string|
      # See StringTest#test_whitespace_then_character_string
      words << string.match(/[a-z\'\-]+/i).to_s unless string.empty?
    end
    
    return words
  end
  
  def matches_for(pattern)
    matches = []
    self.gsub(pattern) do |match|
      matches << match
    end
    return matches
  end
  
  # A sentence is determined to be grammatically correct if
  # a final state in the ATN is reached by the last word in the sentence.
  def grammatical?(language = :english)
    begin
      parse(language)
      return true
    rescue UngrammaticalException => e
      return false
    end
  end
  
  # TODO add tests
  def check_grammar(language = :english)
    checked = []
    
    sentences.each do |sentence|
      if sentence.grammatical?
        checked << sentence
      else
        # TODO needs "yield message" etc
        checked << (yield sentence) # TODO e.message
      end
      
      # begin
      #   parse(language)
      #   checked << sentence
      # rescue UngrammaticalException
      #   checked << (yield sentence)
      # end
    end
    
    return checked.join("  ")
  end
  
  private
    def parse(language)
      # Keep the ATN class-level to avoid the performance hit of creating one for each string
      # I'd like to do it in the constructor, but don't know a good way.
      @@atn ||= ATN.new(language)
      @@atn.parse(self)
    end
end