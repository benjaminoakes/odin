require File.dirname(__FILE__)/'..'/'test_helper'
# require File.dirname(__FILE__) + '/abstract_unit'
require File.dirname(__FILE__)/'..'/'..'/'lang'/'en'/'noun_inflector_test_cases.rb' # TODO no "en"

module Ace
  module Base
    class Case
    end
  end
end

class NounInflectorTest < Test::Unit::TestCase
  include NounInflectorTestCases

  def test_pluralize_plurals
    assert_equal "plurals", NounInflector.pluralize("plurals")
    assert_equal "Plurals", NounInflector.pluralize("Plurals")
  end

  def test_pluralize_empty_string
    assert_equal "", NounInflector.pluralize("")
  end

  SingularToPlural.each do |singular, plural|
    define_method "test_pluralize_#{singular}" do
      assert_equal(plural, NounInflector.pluralize(singular))
      assert_equal(plural.capitalize, NounInflector.pluralize(singular.capitalize))
    end
  end

  SingularToPlural.each do |singular, plural|
    define_method "test_singularize_#{plural}" do
      assert_equal(singular, NounInflector.singularize(plural))
      assert_equal(singular.capitalize, NounInflector.singularize(plural.capitalize))
    end
  end

  MixtureToTitleCase.each do |before, titleized|
    define_method "test_titleize_#{before}" do
      assert_equal(titleized, NounInflector.titleize(before))
    end
  end

  def test_camelize
    CamelToUnderscore.each do |camel, underscore|
      assert_equal(camel, NounInflector.camelize(underscore))
    end
  end

  def test_underscore
    CamelToUnderscore.each do |camel, underscore|
      assert_equal(underscore, NounInflector.underscore(camel))
    end
    CamelToUnderscoreWithoutReverse.each do |camel, underscore|
      assert_equal(underscore, NounInflector.underscore(camel))
    end
  end

  def test_camelize_with_module
    CamelWithModuleToUnderscoreWithSlash.each do |camel, underscore|
      assert_equal(camel, NounInflector.camelize(underscore))
    end
  end

  def test_underscore_with_slashes
    CamelWithModuleToUnderscoreWithSlash.each do |camel, underscore|
      assert_equal(underscore, NounInflector.underscore(camel))
    end
  end

  def test_demodulize
    assert_equal "Account", NounInflector.demodulize("MyApplication::Billing::Account")
  end

  def test_foreign_key
    ClassNameToForeignKeyWithUnderscore.each do |klass, foreign_key|
      assert_equal(foreign_key, NounInflector.foreign_key(klass))
    end

    ClassNameToForeignKeyWithoutUnderscore.each do |klass, foreign_key|
      assert_equal(foreign_key, NounInflector.foreign_key(klass, false))
    end
  end

  def test_tableize
    ClassNameToTableName.each do |class_name, table_name|
      assert_equal(table_name, NounInflector.tableize(class_name))
    end
  end

  def test_classify
    ClassNameToTableName.each do |class_name, table_name|
      assert_equal(class_name, NounInflector.classify(table_name))
      assert_equal(class_name, NounInflector.classify("table_prefix." + table_name))
    end
  end

  def test_classify_with_symbol
    assert_nothing_raised do
      assert_equal 'FooBar', NounInflector.classify(:foo_bars)
    end
  end

  def test_classify_with_leading_schema_name
    assert_equal 'FooBar', NounInflector.classify('schema.foo_bar')
  end

  def test_humanize
    UnderscoreToHuman.each do |underscore, human|
      assert_equal(human, NounInflector.humanize(underscore))
    end
  end

  def test_constantize
    assert_nothing_raised { assert_equal Ace::Base::Case, NounInflector.constantize("Ace::Base::Case") }
    assert_nothing_raised { assert_equal Ace::Base::Case, NounInflector.constantize("::Ace::Base::Case") }
    assert_nothing_raised { assert_equal NounInflectorTest, NounInflector.constantize("NounInflectorTest") }
    assert_nothing_raised { assert_equal NounInflectorTest, NounInflector.constantize("::NounInflectorTest") }
    assert_raises(NameError) { NounInflector.constantize("UnknownClass") }
    assert_raises(NameError) { NounInflector.constantize("An invalid string") }
    assert_raises(NameError) { NounInflector.constantize("InvalidClass\n") }
  end

  if RUBY_VERSION < '1.9.0'
    def test_constantize_does_lexical_lookup
      assert_raises(NameError) { NounInflector.constantize("Ace::Base::NounInflectorTest") }
    end
  else
    def test_constantize_does_dynamic_lookup
      assert_equal self.class, NounInflector.constantize("Ace::Base::NounInflectorTest")
    end
  end

  def test_ordinal
    OrdinalNumbers.each do |number, ordinalized|
      assert_equal(ordinalized, NounInflector.ordinalize(number))
    end
  end

  def test_dasherize
    UnderscoresToDashes.each do |underscored, dasherized|
      assert_equal(dasherized, NounInflector.dasherize(underscored))
    end
  end

  def test_underscore_as_reverse_of_dasherize
    UnderscoresToDashes.each do |underscored, dasherized|
      assert_equal(underscored, NounInflector.underscore(NounInflector.dasherize(underscored)))
    end
  end

  def test_underscore_to_lower_camel
    UnderscoreToLowerCamel.each do |underscored, lower_camel|
      assert_equal(lower_camel, NounInflector.camelize(underscored, false))
    end
  end
  
  %w{plurals singulars uncountables}.each do |inflection_type|
    class_eval "
      def test_clear_#{inflection_type}
        cached_values = NounInflector.inflections.#{inflection_type}
        NounInflector.inflections.clear :#{inflection_type}
        assert NounInflector.inflections.#{inflection_type}.empty?, \"#{inflection_type} inflections should be empty after clear :#{inflection_type}\"
        NounInflector.inflections.instance_variable_set :@#{inflection_type}, cached_values
      end
    "
  end
  
  def test_clear_all
    cached_values = NounInflector.inflections.plurals, NounInflector.inflections.singulars, NounInflector.inflections.uncountables
    NounInflector.inflections.clear :all
    assert NounInflector.inflections.plurals.empty?
    assert NounInflector.inflections.singulars.empty?
    assert NounInflector.inflections.uncountables.empty?
    NounInflector.inflections.instance_variable_set :@plurals, cached_values[0]
    NounInflector.inflections.instance_variable_set :@singulars, cached_values[1]
    NounInflector.inflections.instance_variable_set :@uncountables, cached_values[2]
  end
  
  def test_clear_with_default
    cached_values = NounInflector.inflections.plurals, NounInflector.inflections.singulars, NounInflector.inflections.uncountables
    NounInflector.inflections.clear
    assert NounInflector.inflections.plurals.empty?
    assert NounInflector.inflections.singulars.empty?
    assert NounInflector.inflections.uncountables.empty?
    NounInflector.inflections.instance_variable_set :@plurals, cached_values[0]
    NounInflector.inflections.instance_variable_set :@singulars, cached_values[1]
    NounInflector.inflections.instance_variable_set :@uncountables, cached_values[2]
  end

  Irregularities.each do |irregularity|
    singular, plural = *irregularity
    NounInflector.inflections do |inflect|
      define_method("test_irregularity_between_#{singular}_and_#{plural}") do
        inflect.irregular(singular, plural)
        assert_equal singular, NounInflector.singularize(plural)
        assert_equal plural, NounInflector.pluralize(singular)
      end
    end
  end

  [ :all, [] ].each do |scope|
    NounInflector.inflections do |inflect|
      define_method("test_clear_inflections_with_#{scope.kind_of?(Array) ? "no_arguments" : scope}") do
        # save all the inflections
        singulars, plurals, uncountables = inflect.singulars, inflect.plurals, inflect.uncountables

        # clear all the inflections
        inflect.clear(*scope)

        assert_equal [], inflect.singulars
        assert_equal [], inflect.plurals
        assert_equal [], inflect.uncountables

        # restore all the inflections
        singulars.reverse.each { |singular| inflect.singular(*singular) }
        plurals.reverse.each   { |plural|   inflect.plural(*plural) }
        inflect.uncountable(uncountables)

        assert_equal singulars, inflect.singulars
        assert_equal plurals, inflect.plurals
        assert_equal uncountables, inflect.uncountables
      end
    end
  end

  { :singulars => :singular, :plurals => :plural, :uncountables => :uncountable }.each do |scope, method|
    NounInflector.inflections do |inflect|
      define_method("test_clear_inflections_with_#{scope}") do
        # save the inflections
        values = inflect.send(scope)

        # clear the inflections
        inflect.clear(scope)

        assert_equal [], inflect.send(scope)

        # restore the inflections
        if scope == :uncountables
          inflect.send(method, values)
        else
          values.reverse.each { |value| inflect.send(method, *value) }
        end

        assert_equal values, inflect.send(scope)
      end
    end
  end
end