require 'rubygems'
require 'facets'

require File.dirname(__FILE__) + '/parts_of_speech.rb'

# We have a separate class for this so that we know there are no spaces
#
# Uses the state pattern for parts of speech.  (Needs "facets")
# See http://blog.jayfields.com/2007/08/ruby-state-pattern-using-modules-and.html
# and http://blog.jayfields.com/2007/08/ruby-calling-methods-of-specific.html
class Word < String
  include ClosedClassWords
  
  include Adjective
  include Noun
  include Verb
  
  def initialize(content)
    if content.words.length > 1
      raise FormatException, "'#{content}' contains more than one word"
    else
      # Keeping a normalized form separate is nice for when we print out the output later.
      @normalized = content.normalize
      @part_of_speech = determine_part_of_speech
      super(content)
    end
  end
  
  def part_of_speech
    return @part_of_speech
  end
  
  def plural?
    # TODO
    as(@part_of_speech).plural?
  end
  
  def singular?
    # TODO
    as(@part_of_speech).singular?
  end
  
  def inspect
    return "\"#{self}\" (#{@part_of_speech.to_s})"
  end
  
  private 
    def determine_part_of_speech
      # TODO
      if @@Determiners.member?(@normalized) or @@PossesiveAdjectives.member?(@normalized)
        return Determiner
      elsif @@Pronouns.member?(@normalized)
        return Pronoun
      elsif @@Prepositions.member?(@normalized)
        return Preposition
      elsif @@IrregularVerbs.member?(@normalized) or @@RegularVerbs.member?(@normalized)
        return Verb
      elsif @@Adjectives.member?(@normalized)
        return Adjective
      elsif @@Conjunctions.member?(@normalized)
        return Conjuction
      else
        # TODO add an error
        return Noun
      end
    end
    
    class FormatException < Exception; end
end