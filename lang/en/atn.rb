module English
  # TODO before_function :next_word
  
  def sentence
    subject = required_phrase do
      noun_phrase
    end
    
    verb = required_phrase do
      verb_phrase
    end
    
    return tag_phrase("S", subject + verb)
  end
  
  alias :root :sentence
  
  def noun_phrase
    next_word
    
    # TODO remove these
    determiner = ""
    adjective = ""
    preposition = ""
    
    if Pronoun == @star.part_of_speech
      noun = tag("N", @star)
    else
      determiner = optional Determiner do |word|
        next_word
        tag("D", word)
      end
      
      adjective = optional Adjective do
        # TODO convert to optional_phrase
        adjective_phrase
      end
      
      noun = required Noun do |word|
        tag("N", word)
      end
      
      preposition = optional_phrase do
        prepositional_phrase
      end
    end
    
    return tag_phrase("NP", determiner + adjective + noun + preposition)
  end
  
  def adjective_phrase
    adjective = ""
    while Adjective == @star.part_of_speech
      adjective += tag("A", @star)
      next_word
    end
    # tag_phrase ?
    return adjective
  end
  
  def prepositional_phrase
    # next_word
    # 
    # preposition = ""
    # object = ""
    # 
    # required Preposition do |word|
    #   preposition = tag("P", word)
    # end
    # 
    # required_phrase do
    #   object = noun_phrase
    # end
    # 
    # return tag_phrase("PP", preposition + object)
    # 
    
    if Preposition == Word.new(@words[0]).part_of_speech
      next_word
      preposition = tag("P", @star)
      output = tag_phrase("PP", preposition + noun_phrase)
    else
      output = ""
    end
    
    return output
  end
  
  def verb_phrase
    next_word
    
    verb = required Verb do |word|
      tag("V", word)
    end
    
    object = optional_phrase do
      noun_phrase
    end
    
    return tag_phrase("VP", verb + object)
  end
end