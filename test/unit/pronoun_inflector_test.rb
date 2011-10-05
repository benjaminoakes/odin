require File.dirname(__FILE__)/'..'/'test_helper'
require File.dirname(__FILE__)/'..'/'..'/'lang'/'en'/'pronoun_inflector_test_cases.rb' # TODO no "en"

class PronounInflectorTest < Test::Unit::TestCase
  include ClosedClassWords
  include PronounInflectorTestCases
  
  # @@SingularPronouns.each do |singular|
  #   define_method "test_#{singular}_singular" do
  #     assert(Word.new(singular).singular?)
  #   end
  # end
  
  def test_truth
    assert_equal(true, true)
  end
end