require File.dirname(__FILE__)/'..'/'..'/'test_helper'

class WordAndNounInflectorTest < Test::Unit::TestCase
  include NounInflectorTestCases
  
  PluralToSingular.each do |plural, singular|
    define_method "test_#{plural}_plural" do
      assert(Word.new(plural).plural?)
    end
  end
  
  SingularToPlural.each do |singular, plural|
    define_method "test_#{singular}_singular" do
      assert(Word.new(singular).singular?)
    end
  end
  
  # PluralToSingular.each do |plural, singular|
  #   define_method "test_#{singular}_not_plural" do
  #     assert(!Word.new(singular).plural?)
  #   end
  # end
  # 
  # PluralToSingular.each do |plural, singular|
  #   define_method "test_#{plural}_not_singular" do
  #     assert(!Word.new(plural).singular?)
  #   end
  # end
end