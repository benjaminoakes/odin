require File.dirname(__FILE__)/'..'/'test_helper'
require File.dirname(__FILE__)/'..'/'..'/'app'/'controllers'/'grammar_checker.rb'
require "find"

class GrammarCheckerTest < Test::Unit::TestCase
  def teardown
    Find.find(@@FixturesDirectory) do |file_name|
      if file_name.match(/.*\.#{GrammarChecker.suffix}$/) and not file_name.match(/existing/)
        File.delete(file_name)
      end
    end
  end
  
  def test_fail_when_given_no_file
    assert_raise(ArgumentError) do
      GrammarChecker.check(nil)
    end
  end
  
  def test_fail_when_given_nonexistent_file
    assert_raise(Errno::ENOENT) do
      GrammarChecker.check("nonexistent_file.txt")
    end
  end
  
  def test_fail_when_given_existing_out_file
    assert_raise(Errno::EEXIST) do
      GrammarChecker.check(@@FixturesDirectory/"existing.txt")
    end
  end
  
  def test_fail_when_given_directory
    assert_raise(Errno::EISDIR) do
      GrammarChecker.check(@@FixturesDirectory)
    end
  end
  
  # Regression test: the output of GrammarChecker used to differ from the output of the unit tests
  # when used from the command line because word.rb wasn't imported before string.rb
  def test_no_ungrammatical_when_checking_grammatical
    file_name = @@FixturesDirectory/"grammatical.txt"
    GrammarChecker.check(file_name)
    
    File.open("#{file_name}.#{GrammarChecker.suffix}") do |file|
      while line = file.gets
        assert(!contains_ungrammatical?(line))
      end
    end
  end
  
  def test_ungrammatical_when_checking_ungrammatical
    # TODO
    # Would have to check each sentence
  end
  
  private
    def contains_ungrammatical?(string)
      if string.match(/<[a-z="]*?ungrammatical[a-z="]*?>/)
        return true
      else
        return false
      end
    end
end