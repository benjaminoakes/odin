require File.dirname(__FILE__)/'..'/'lang'/'en'/'atn.rb' # TODO no "en"

class ATN
  include English
  
  def initialize(language = :english, dialect = :US, allow_passive = true)
    if :english == language
      # @tree = []
    else
      raise LanguageException("Unsupported language.")
    end
  end
  
  def parse(string)
    output = ""
    string.sentences.each do |sentence|
      @words = sentence.words
      output += root
    end
    
    return output
  end
  
  private
    # @deprecated
    def next_word
      unless @words.empty?
        @star = Word.new(@words.shift)
      else
        raise FragmentException.new("Fragment (consider revising)")
      end
    end
    
    def tag(marker, word)
      marker + word.quote.bracket('(')
    end
    
    def tag_phrase(marker, phrase)
      marker + phrase.bracket('(')
    end
    
    # The following methods probably aren't the most efficient way of doing things (passing around
    # blocks in particular).  However, it makes the implementation simpler.
    
    def optional(part_of_speech, &block)
      begin
        return required(part_of_speech, &block)
      rescue UngrammaticalException
        # Ignore it--this is optional
        return ""
      end
    end
    
    def required(part_of_speech, &block)
      if part_of_speech == @star.part_of_speech
        return (yield @star)
      else
        raise UngrammaticalException.new("Missing #{part_of_speech.to_s.downcase}: received #{@star.quote}")
      end
    end
    
    def optional_phrase(&block)
      begin
        return required_phrase(&block)
      rescue UngrammaticalException
        # Ignore it--this is optional
        return ""
      end
    end
    
    def required_phrase(&block)
      if not @words.empty?
        return yield
      else
        raise UngrammaticalException.new("Incomplete phrase")
      end
    end
end

class UngrammaticalException < Exception; end
class FragmentException < UngrammaticalException; end
class PassiveException < UngrammaticalException; end