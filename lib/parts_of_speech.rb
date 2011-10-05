require File.dirname(__FILE__) + '/noun_inflector.rb'
require File.dirname(__FILE__) + '/../lang/en/closed_class_words.rb'
require File.dirname(__FILE__) + '/../lang/en/adjectives.rb'
require File.dirname(__FILE__) + '/../lang/en/verbs.rb'

# Part of speech implementations for the state pattern.
module Conjuction
  # Intentionally left blank
end

module Determiner
  # Intentionally left blank
end

module Pronoun
  # def singular?
  #   @@SingularPronouns.member?(self)
  # end
  # 
  # def plural?
  #   @@PluralPronouns.member?(self)
  # end
  
  # def pluralize
  #   
  # end
end

module Preposition
  # Intentionally left blank
end

module Adjective
  include CachedAdjectives
end

module Noun
  include NounInflector
  
  protected
    def plural?
      # TODO
      # puts "-" * 20
      # puts("self: #{self}")
      # puts("singularize(self): #{singularize(self)}")
      # puts("pluralize(self): #{pluralize(self)}")
      # puts("pluralize(singularize(self)): #{pluralize(singularize(self))}")
      # puts("singularize(pluralize(self)): #{singularize(pluralize(self))}")
      # 
      # plural = self == pluralize(singularize(self))
      # singular = self == singularize(pluralize(self))
      # 
      # puts("plural: #{plural}")
      # puts("singular: #{singular}")
      # puts("plural and singular: #{plural and singular}")
      # puts("plural or !singular or (plural and singular): #{plural or !singular or (plural and singular)}")
      
      return (pluralize(singularize(self)) or !singular?)
    end
    
    def singular?
      # TODO
      # plural = self == pluralize(singularize(self))
      # singular = self == singularize(pluralize(self))
      
      return (self == singularize(pluralize(self)) or !plural?)
    end
end

module Verb
  include CachedVerbs
  
  protected  
    # def pluralize
    #   # TODO
    #   "#{self}"
    # end
    
    # TODO How can we keep this separate from Nouns?
    # def present_participle?
    #  # TODO
    # end
    
  # ### The object class for the result returned from calling
  # ### Linguistics::EN::infinitive.
  # class Infinitive < String
  # 
  #         ### Create and return a new Infinitive object.
  #         def initialize( word1, word2, suffix, rule )
  #                 super( word1 )
  #                 @word2 = word2
  #                 @suffix = suffix
  #                 @rule = rule
  #         end
  # 
  # 
  #         ######
  #         public
  #         ######
  # 
  #         # The fallback deconjugated form
  #         attr_reader :word2
  # 
  #         # The suffix used to to identify the transform rule
  #         attr_reader :suffix
  # 
  #         # The rule used
  #         attr_reader :rule
  # end
  
  # ###############
  # module_function
  # ###############
  # 
  # ### Return the infinitive form of the given word
  # def infinitive( word )
  #         word = word.to_s
  #         word1 = word2 = suffix = rule = newword = ''
  # 
  #         if IrregularInfinitives.key?( word )
  #                 word1   = IrregularInfinitives[ word ]
  #                 rule    = 'irregular'
  #         else
  #                 # Build up $prefix{$suffix} as an array of prefixes, from longest to shortest.
  #                 prefix, suffix = nil
  #                 prefixes = Hash::new {|hsh,key| hsh[key] = []}
  # 
  #                 # Build the hash of prefixes for the word
  #                 1.upto( word.length ) {|i|
  #                         prefix = word[0, i]
  #                         suffix = word[i..-1]
  # 
  #                         (suffix.length - 1).downto( 0 ) {|j|
  #                                 newword = prefix + suffix[0, j]
  #                                 prefixes[ suffix ].push( newword )
  #                         }
  #                 }
  # 
  #                 $stderr.puts "prefixes: %p" % prefixes if $DEBUG
  # 
  #                 # Now check for rules covering the prefixes for this word, picking
  #                 # the first one if one was found.
  #                 if (( suffix = ((InfSuffixRuleOrder & prefixes.keys).first) ))
  #                         rule = InfSuffixRules[ suffix ][:rule]
  #                         shortestPrefix = InfSuffixRules[ suffix ][:word1]
  #                         $stderr.puts "Using rule %p (%p) for suffix %p" %
  #                                 [ rule, shortestPrefix, suffix ] if $DEBUG
  # 
  #                         case shortestPrefix
  #                         when 0
  #                                 word1 = prefixes[ suffix ][ 0 ]
  #                                 word2 = prefixes[ suffix ][ 1 ]
  #                                 $stderr.puts "For sp = 0: word1: %p, word2: %p" %
  #                                         [ word1, word2 ] if $DEBUG
  # 
  #                         when -1
  #                                 word1 = prefixes[ suffix ].last +
  #                                         InfSuffixRules[ suffix ][:suffix1]
  #                                 word2 = ''
  #                                 $stderr.puts "For sp = -1: word1: %p, word2: %p" %
  #                                         [ word1, word2 ] if $DEBUG
  # 
  #                         when -2
  #                                 word1 = prefixes[ suffix ].last +
  #                                         InfSuffixRules[ suffix ][:suffix1]
  #                                 word2 = prefixes[ suffix ].last
  #                                 $stderr.puts "For sp = -2: word1: %p, word2: %p" %
  #                                         [ word1, word2 ] if $DEBUG
  # 
  #                         when -3
  #                                 word1 = prefixes[ suffix ].last +
  #                                         InfSuffixRules[ suffix ][:suffix1]
  #                                 word2 = prefixes[ suffix ].last +
  #                                         InfSuffixRules[ suffix ][:suffix2]
  #                                 $stderr.puts "For sp = -3: word1: %p, word2: %p" %
  #                                         [ word1, word2 ] if $DEBUG
  # 
  #                         when -4
  #                                 word1 = word
  #                                 word2 = ''
  #                                 $stderr.puts "For sp = -4: word1: %p, word2: %p" %
  #                                         [ word1, word2 ] if $DEBUG
  # 
  #                         else
  #                                 raise IndexError,
  #                                         "Couldn't find rule for shortest prefix %p" %
  #                                         shortestPrefix
  #                         end
  # 
  #                         # Rules 12b and 15: Strip off 'ed' or 'ing'.
  #                         if rule == '12b' or rule == '15'
  #                                 # Do we have a monosyllable of this form:
  #                                 # o 0+ Consonants
  #                                 # o 1+ Vowel
  #                                 # o     2 Non-wx
  #                                 # Eg: tipped => tipp?
  #                                 # Then return tip and tipp.
  #                                 # Eg: swimming => swimm?
  #                                 # Then return tipswim and swimm.
  # 
  #                                 if /^([^aeiou]*[aeiou]+)([^wx])\2$/ =~ word2
  #                                         word1 = $1 + $2
  #                                         word2 = $1 + $2 + $2
  #                                 end
  #                         end
  #                 end
  #         end
  # 
  #         return Infinitive::new( word1, word2, suffix, rule )
  # end
end

# # From the Ruby Linguistics Project, release 1.0.5
# # http://www.deveiate.org/projects/Linguistics/browser/tags/RELEASE_1_0_5/lib/linguistics/en.rb
# # CREDIT: deveiate
# 
# ### Return the given phrase with the appropriate indefinite article ("a" or
# ### "an") prepended.
# def a( phrase, count=nil )
#   md = /\A(\s*)(.+?)(\s*)\Z/.match( phrase.to_s )
#   pre, word, post = md.to_a[1,3]
#   return phrase if word.nil? or word.empty?
#   
#   result = indef_article( word, count )
#   return pre + result + post
# end
# 
# ### Returns the given word with a prepended indefinite article, unless
# ### +count+ is non-nil and not singular.
# def indef_article( word, count )
#         count ||= Linguistics::num
#         return "#{count} #{word}" if
#                 count && /^(#{PL_count_one})$/i !~ count.to_s
# 
#         # Handle user-defined variants
#         # return value if value = ud_match( word, A_a_user_defined )
# 
#         case word
# 
#         # Handle special cases
#         when /^(#{A_explicit_an})/i
#                 return "an #{word}"
# 
#         # Handle abbreviations
#         when /^(#{A_abbrev})/x
#                 return "an #{word}"
#         when /^[aefhilmnorsx][.-]/i
#                 return "an #{word}"
#         when /^[a-z][.-]/i     
#                 return "a #{word}"
# 
#         # Handle consonants
#         when /^[^aeiouy]/i
#                 return "a #{word}"
# 
#         # Handle special vowel-forms
#         when /^e[uw]/i 
#                 return "a #{word}"
#         when /^onc?e\b/i       
#                 return "a #{word}"
#         when /^uni([^nmd]|mo)/i
#                 return "a #{word}"
#         when /^u[bcfhjkqrst][aeiou]/i
#                 return "a #{word}"
# 
#         # Handle vowels
#         when /^[aeiou]/i
#                 return "an #{word}"
# 
#         # Handle y... (before certain consonants implies (unnaturalized) "i.." sound)
#         when /^(#{A_y_cons})/i
#                 return "an #{word}"
# 
#         # Otherwise, guess "a"
#         else
#                 return "a #{word}"
#         end
# end
# 
# def normalize_count( count, default=2 )
#         return default if count.nil? # Default to plural
#         if /^(#{PL_count_one})$/i =~ count.to_s ||
#                         Linguistics::classical? &&
#                         /^(#{PL_count_zero})$/ =~ count.to_s
#                 return 1
#         else
#                 return default
#         end
# end
# 
# ### Do normal/classical switching and match capitalization in <tt>inflected</tt> by
# ### examining the <tt>original</tt> input.
# def postprocess( original, inflected )
#         inflected.sub!( /([^|]+)\|(.+)/ ) {
#                 Linguistics::classical? ? $2 : $1
#         }
# 
#         case original
#         when "I"
#                 return inflected
#         when /^[A-Z]+$/
#                 return inflected.upcase
#         when /^[A-Z]/
#                 # Can't use #capitalize, as it will downcase the rest of the string,
#                 # too.
#                 inflected[0,1] = inflected[0,1].upcase
#                 return inflected
#         else
#                 return inflected
#         end
# end
# 
# ### Return the plural of the given verb +phrase+ if +count+ indicates it
# ### should be plural.
# def plural_verb( phrase, count=nil )
#   md = /\A(\s*)(.+?)(\s*)\Z/.match( phrase.to_s )
#   pre, word, post = md.to_a[1,3]
#   return phrase if word.nil? or word.empty?
# 
#   plural = postprocess( word,
#           pluralize_special_verb(word, count) ||
#           pluralize_general_verb(word, count) )
#   return pre + plural + post
# end
# 
# def pluralize_special_verb( word, count )
#   count ||= Linguistics::num
#   count = normalize_count( count )
#  
#   return nil if /^(#{PL_count_one})$/i =~ count.to_s
# 
#   # Handle user-defined verbs
#   #if value = ud_match( word, PL_v_user_defined )
#   #       return value
#   #end
# 
#   case word
# 
#   # Handle irregular present tense (simple and compound)
#   when /^(#{PL_v_irregular_pres})((\s.*)?)$/i
#           return PL_v_irregular_pres_h[ $1.downcase ] + $2
# 
#   # Handle irregular future, preterite and perfect tenses
#   when /^(#{PL_v_irregular_non_pres})((\s.*)?)$/i
#           return word
# 
#   # Handle special cases
#   when /^(#{PL_v_special_s})$/, /\s/
#           return nil
# 
#   # Handle standard 3rd person (chop the ...(e)s off single words)
#   when /^(.*)([cs]h|[x]|zz|ss)es$/i
#           return $1 + $2
#   when /^(..+)ies$/i
#           return "#{$1}y"
#   when /^(.+)oes$/i
#           return "#{$1}o"
#   when /^(.*[^s])s$/i
#           return $1
# 
#   # Otherwise, a regular verb (handle elsewhere)
#   else
#           return nil
#   end
# end
# 
# ### Pluralize regular verbs
# def pluralize_general_verb( word, count )
#         count ||= Linguistics::num
#         count = normalize_count( count )
#        
#         return word if /^(#{PL_count_one})$/i =~ count.to_s
# 
#         case word
# 
#         # Handle ambiguous present tenses  (simple and compound)
#         when /^(#{PL_v_ambiguous_pres})((\s.*)?)$/i
#                 return PL_v_ambiguous_pres_h[ $1.downcase ] + $2
# 
#         # Handle ambiguous preterite and perfect tenses
#         when /^(#{PL_v_ambiguous_non_pres})((\s.*)?)$/i
#                 return word
# 
#         # Otherwise, 1st or 2nd person is uninflected
#         else
#                 return word
#         end
# end
# 
# def present_participle( word )
#   plural = plural_verb( word.to_s, 2 )
#      
#   plural.sub!( /ie$/, 'y' ) or
#     plural.sub!( /ue$/, 'u' ) or
#     plural.sub!( /([auy])e$/, '$1' ) or
#     plural.sub!( /i$/, '' ) or
#     plural.sub!( /([^e])e$/, "\\1" ) or
#     /er$/.match( plural ) or
#     plural.sub!( /([^aeiou][aeiouy]([bdgmnprst]))$/, "\\1\\2" )
#   
#   return "#{plural}ing"
# end