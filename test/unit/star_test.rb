require File.dirname(__FILE__)/'..'/'test_helper'

class StarTest < Test::Unit::TestCase
  def setup
    @test_words = ['one', 'two', 'three']
    @star = Star.new('one', 'two', 'three')
  end
  
  def test_identify_fragment
    assert_raise(FragmentException) do
      @test_words.length.times do
        @star.next
      end
    end
  end
  
  def test_identify_not_a_fragment
    assert_nothing_raised(FragmentException) do
      (@test_words.length - 1).times do
        @star.next
      end
    end
  end
end