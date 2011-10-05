class String
  def adjective?
    'old' == self
  end
  
  def determiner?
    'the' == self
  end
  
  def noun?
    case self
    when 'man', 'avocados', 'cookie', 'monster', 'street'
      true
    else
      false
    end
  end
  
  def present_participle?
    'smiling' == self
  end
  
  def past_participle?
    'eaten' == self
  end
  
  def preposition?
    'in' == self
  end
  
  def preterite
    if 'eaten' == self
      return 'ate'
    else
      return self
    end
  end
  
  def pronoun?
    'you' == self
  end
  
  def verb?
    case self
    when 'grows', 'eat', 'ate', 'was'
      true
    else
      false
    end
  end
  
  def matches_for(pattern)
    matches = []
    self.gsub(pattern) do |match|
      matches << match
    end
    return matches
  end
  
  def number_in_quotes
    matches_for(/".*?"/).length
  end
end