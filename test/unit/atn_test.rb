require File.dirname(__FILE__)/'..'/'test_helper'

class ATNTest < Test::Unit::TestCase
  def setup
    @atn = ATN.new
    @grammatical_sentences = []
    
    # TODO move this to an English specific test file?
    # Sentences named according to structure
    #
    # Key:
    # 
    # a: adjective
    # d: determiner
    # n: noun
    # P: preposition
    # p: pronoun
    # v: verb
    #
    @grammatical_sentences << @pv = "I love."
    @grammatical_sentences << @pvp = "She loves you."
    @grammatical_sentences << @pvn = "She loves apples."
    @grammatical_sentences << @pvdn = "I love the girl."
    @grammatical_sentences << @pvan = "I love ripe apples."
    @grammatical_sentences << @pvdan = "I love the pretty girl."
    @grammatical_sentences << @pvdaan = "I love the pretty, sweet girl."
    
    @grammatical_sentences << @nv = "Man loves."
    @grammatical_sentences << @nvn = "Man loves apples."
    @grammatical_sentences << @nvdn = "Man loves the apples."
    @grammatical_sentences << @nvan = "Man loves sweet apples."
    @grammatical_sentences << @nvdan = "Man loves the sweet apples."
    @grammatical_sentences << @nvdaan = "Man loves the sweet, pretty apples."
    
    @grammatical_sentences << @dnv = "The man loves."
    @grammatical_sentences << @dnvn = "The man loves apples."
    @grammatical_sentences << @dnvdn = "The man loves the apples."
    @grammatical_sentences << @dnvan = "The man loves sweet apples."
    @grammatical_sentences << @dnvdan = "The man loves the sweet apples."
    @grammatical_sentences << @dnvdaan = "The man loves the sweet, pretty apples."
    
    @grammatical_sentences << @dnPnvp = "The woman in house loves you."
    @grammatical_sentences << @dnPanvp = "The woman in pretty house loves you."
    @grammatical_sentences << @dnPdnvp = "The woman in the house loves you."
    @grammatical_sentences << @dnPdanvp = "The woman in the pretty house loves you."
    
    @grammatical_sentences << @anv = "Old men love."
    @grammatical_sentences << @anvn = "Old men love apples."
    @grammatical_sentences << @anvdn = "Old men love the apples."
    @grammatical_sentences << @anvan = "Old men love sweet apples."
    @grammatical_sentences << @anvdan = "Old men love the sweet apples."
    @grammatical_sentences << @anvdaan = "Old men love the sweet, pretty apples."
    
    @grammatical_sentences << @danv = "The old man loves."
    @grammatical_sentences << @danvn = "The old man loves apples."
    @grammatical_sentences << @danvdn = "The old man loves the apples."
    @grammatical_sentences << @danvan = "The old man loves sweet apples."
    @grammatical_sentences << @danvdan = "The old man loves the sweet apples."
    @grammatical_sentences << @danvdaan = "The old man loves the sweet, pretty apples."
    
    @grammatical_sentences << @daanv = "The old, old man loves."
    @grammatical_sentences << @daanvn = "The old, old man loves apples."
    @grammatical_sentences << @daanvdn = "The old, old man loves the apples."
    @grammatical_sentences << @daanvan = "The old, old man loves sweet apples."
    @grammatical_sentences << @daanvdan = "The old, old man loves the sweet apples."
    @grammatical_sentences << @daanvdaan = "The old, old man loves the sweet, pretty apples."  
    
    @grammatical_sentences << @pvp = "She loves you."
    @grammatical_sentences << @nvp = "Men love you."
    @grammatical_sentences << @dnvp = "The man loves you."
    @grammatical_sentences << @anvp = "Sweet men love you."
    @grammatical_sentences << @danvp = "The sweet man loves you."
    @grammatical_sentences << @daanvp = "The sweet, handsome man loves you."
    
    @word = /'[a-z]+'/i
  end
  
  def test_grammatical_pv__parse
    # TODO switch to match?
    # assert_match(/S\(NP\(N\(#{@word}\)\)VP\(V\(#{@word}\)\)\)/i, @atn.parse(@pv))
    # /S<NP<N<#{@word}>VP<V<#{@word}>>>/i would be easier
    assert_equal("S(NP(N('I'))VP(V('love')))", @atn.parse(@pv))
    assert_equal("S(NP(N('She'))VP(V('loves')NP(N('you'))))", @atn.parse(@pvp))
    assert_equal("S(NP(N('She'))VP(V('loves')NP(N('apples'))))", @atn.parse(@pvn))
    assert_equal("S(NP(N('I'))VP(V('love')NP(D('the')N('girl'))))", @atn.parse(@pvdn))
    assert_equal("S(NP(N('I'))VP(V('love')NP(A('ripe')N('apples'))))", @atn.parse(@pvan))
    assert_equal("S(NP(N('I'))VP(V('love')NP(D('the')A('pretty')N('girl'))))", @atn.parse(@pvdan))
    assert_equal("S(NP(N('I'))VP(V('love')NP(D('the')A('pretty')A('sweet')N('girl'))))", @atn.parse(@pvdaan))
  end
  
  def test_grammatical_nv__parse
    assert_equal("S(NP(N('Man'))VP(V('loves')))", @atn.parse(@nv))
    assert_equal("S(NP(N('Man'))VP(V('loves')NP(N('apples'))))", @atn.parse(@nvn))
    assert_equal("S(NP(N('Man'))VP(V('loves')NP(D('the')N('apples'))))", @atn.parse(@nvdn))
    assert_equal("S(NP(N('Man'))VP(V('loves')NP(A('sweet')N('apples'))))", @atn.parse(@nvan))
    assert_equal("S(NP(N('Man'))VP(V('loves')NP(D('the')A('sweet')N('apples'))))", @atn.parse(@nvdan))
    assert_equal("S(NP(N('Man'))VP(V('loves')NP(D('the')A('sweet')A('pretty')N('apples'))))", @atn.parse(@nvdaan))
  end
  
  def test_grammatical_dnv__parse
    assert_equal("S(NP(D('The')N('man'))VP(V('loves')))", @atn.parse(@dnv))
    assert_equal("S(NP(D('The')N('man'))VP(V('loves')NP(N('apples'))))", @atn.parse(@dnvn))
    assert_equal("S(NP(D('The')N('man'))VP(V('loves')NP(D('the')N('apples'))))", @atn.parse(@dnvdn))
    assert_equal("S(NP(D('The')N('man'))VP(V('loves')NP(A('sweet')N('apples'))))", @atn.parse(@dnvan))
    assert_equal("S(NP(D('The')N('man'))VP(V('loves')NP(D('the')A('sweet')N('apples'))))", @atn.parse(@dnvdan))
    assert_equal("S(NP(D('The')N('man'))VP(V('loves')NP(D('the')A('sweet')A('pretty')N('apples'))))", @atn.parse(@dnvdaan))
  end
  
  def test_grammatical_anv__parse
    assert_equal("S(NP(A('Old')N('men'))VP(V('love')))", @atn.parse(@anv))
    assert_equal("S(NP(A('Old')N('men'))VP(V('love')NP(N('apples'))))", @atn.parse(@anvn))
    assert_equal("S(NP(A('Old')N('men'))VP(V('love')NP(D('the')N('apples'))))", @atn.parse(@anvdn))
    assert_equal("S(NP(A('Old')N('men'))VP(V('love')NP(A('sweet')N('apples'))))", @atn.parse(@anvan))
    assert_equal("S(NP(A('Old')N('men'))VP(V('love')NP(D('the')A('sweet')N('apples'))))", @atn.parse(@anvdan))
    assert_equal("S(NP(A('Old')N('men'))VP(V('love')NP(D('the')A('sweet')A('pretty')N('apples'))))", @atn.parse(@anvdaan))
  end
    
  def test_grammatical_danv__parse
    assert_equal("S(NP(D('The')A('old')N('man'))VP(V('loves')))", @atn.parse(@danv))
    assert_equal("S(NP(D('The')A('old')N('man'))VP(V('loves')NP(N('apples'))))", @atn.parse(@danvn))
    assert_equal("S(NP(D('The')A('old')N('man'))VP(V('loves')NP(D('the')N('apples'))))", @atn.parse(@danvdn))
    assert_equal("S(NP(D('The')A('old')N('man'))VP(V('loves')NP(A('sweet')N('apples'))))", @atn.parse(@danvan))
    assert_equal("S(NP(D('The')A('old')N('man'))VP(V('loves')NP(D('the')A('sweet')N('apples'))))", @atn.parse(@danvdan))
    assert_equal("S(NP(D('The')A('old')N('man'))VP(V('loves')NP(D('the')A('sweet')A('pretty')N('apples'))))", @atn.parse(@danvdaan))
  end
    
  def test_grammatical_daanv__parse
    assert_equal("S(NP(D('The')A('old')A('old')N('man'))VP(V('loves')))", @atn.parse(@daanv))
    assert_equal("S(NP(D('The')A('old')A('old')N('man'))VP(V('loves')NP(N('apples'))))", @atn.parse(@daanvn))
    assert_equal("S(NP(D('The')A('old')A('old')N('man'))VP(V('loves')NP(D('the')N('apples'))))", @atn.parse(@daanvdn))
    assert_equal("S(NP(D('The')A('old')A('old')N('man'))VP(V('loves')NP(A('sweet')N('apples'))))", @atn.parse(@daanvan))
    assert_equal("S(NP(D('The')A('old')A('old')N('man'))VP(V('loves')NP(D('the')A('sweet')N('apples'))))", @atn.parse(@daanvdan))
    assert_equal("S(NP(D('The')A('old')A('old')N('man'))VP(V('loves')NP(D('the')A('sweet')A('pretty')N('apples'))))", @atn.parse(@daanvdaan))
  end
  
  def test_grammatical__vp_parse
    assert_equal("S(NP(N('She'))VP(V('loves')NP(N('you'))))", @atn.parse(@pvp))
    assert_equal("S(NP(N('Men'))VP(V('love')NP(N('you'))))", @atn.parse(@nvp))
    assert_equal("S(NP(D('The')N('man'))VP(V('loves')NP(N('you'))))", @atn.parse(@dnvp))
    assert_equal("S(NP(A('Sweet')N('men'))VP(V('love')NP(N('you'))))", @atn.parse(@anvp))
    assert_equal("S(NP(D('The')A('sweet')N('man'))VP(V('loves')NP(N('you'))))", @atn.parse(@danvp))
    assert_equal("S(NP(D('The')A('sweet')A('handsome')N('man'))VP(V('loves')NP(N('you'))))", @atn.parse(@daanvp))
  end
  
  def test_grammatical__P__phrase
    assert_equal("S(NP(D('The')N('woman')PP(P('in')NP(N('house'))))VP(V('loves')NP(N('you'))))", @atn.parse(@dnPnvp))
    assert_equal("S(NP(D('The')N('woman')PP(P('in')NP(A('pretty')N('house'))))VP(V('loves')NP(N('you'))))", @atn.parse(@dnPanvp))
    assert_equal("S(NP(D('The')N('woman')PP(P('in')NP(D('the')N('house'))))VP(V('loves')NP(N('you'))))", @atn.parse(@dnPdnvp))
    assert_equal("S(NP(D('The')N('woman')PP(P('in')NP(D('the')A('pretty')N('house'))))VP(V('loves')NP(N('you'))))", @atn.parse(@dnPdanvp))
  end
  
  def test_words_match
    # There were some issues with this before, when using instance variables
    # No good reason to remove the test now that it's here.
    @grammatical_sentences.each do |sentence|
      assert_equal(sentence.words.collect { |i| "'#{i}'"}, @atn.parse(sentence).matches_for(/'[a-z]+'/i))
    end
  end
  
  def test_ungrammatical_identified
    ungrammatical_sentences = []
    
    ungrammatical_sentences << p = "I."
    ungrammatical_sentences << d = "The."
    ungrammatical_sentences << dn = "The apple."
    ungrammatical_sentences << dan = "The sweet apple."
    
    # Underscore because initial P would be a constant
    # TODO
    ungrammatical_sentences << _P = "In."
    ungrammatical_sentences << _Pd = "In the."
    ungrammatical_sentences << _Pdn = "In the house."
    
    ungrammatical_sentences << nP = "Man in."
    ungrammatical_sentences << nPd = "Man in the."
    ungrammatical_sentences << nPdn = "Man in the house."
    
    ungrammatical_sentences << nPdv = "Man in the walk."
    
    ungrammatical_sentences << v = "Loves."
    ungrammatical_sentences << vp = "Loves you."
    ungrammatical_sentences << vn = "Loves apples."
    ungrammatical_sentences << vd = "Loves the."
    ungrammatical_sentences << vdn = "Loves the apples."
    ungrammatical_sentences << van = "Loves sweet apples."
    ungrammatical_sentences << vda = "Loves the sweet."
    ungrammatical_sentences << vdan = "Loves the sweet apples."
    
    # Nearly grammatical
    
    ungrammatical_sentences << ddnvp = "The the man loves you."
    ungrammatical_sentences << ddnvn = "The the man loves apples."
    ungrammatical_sentences << ddnvdn = "The the man loves the apples."
    ungrammatical_sentences << ddnvan = "The the man loves sweet apples."
    ungrammatical_sentences << ddnvdan = "The the man loves the sweet apples."
    
    ungrammatical_sentences << ndvn = "Man the loves apples."
    ungrammatical_sentences << dndvn = "The man the loves apples."
    ungrammatical_sentences << dndn = "The man the apples."
    
    ungrammatical_sentences << av = "Handsome loves."
    
    ungrammatical_sentences.each do |sentence|
      assert_raise_kind_of(UngrammaticalException) do
        @atn.parse(sentence)
      end
    end
    
    ungrammatical_sentences.each do |sentence|
      assert(!sentence.grammatical?)
    end
  end
  
  def test_grammatical_identified
    @grammatical_sentences.each do |sentence|
      assert_nothing_raised(UngrammaticalException) do
        @atn.parse(sentence)
      end
    end
    
    @grammatical_sentences.each do |sentence|
      assert(sentence.grammatical?)
    end
  end
  
  def test_corpus_grammatical
    corpus = @grammatical_sentences.join("  ")
    sentences = corpus.sentences
    
    sentences.each do |sentence|
      assert_nothing_raised(UngrammaticalException) do
        @atn.parse(sentence)
      end
    end
    
    sentences.each do |sentence|
      assert(sentence.grammatical?)
    end
  end
end
