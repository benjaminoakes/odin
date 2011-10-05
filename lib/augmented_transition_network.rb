require File.dirname(__FILE__) + '/string'
require File.dirname(__FILE__) + '/array'

class Ungrammatical < Exception; end

class AugmentedTransitionNetwork
  def initialize(language = :en)
    if :en == language
      require File.dirname(__FILE__) + '/english'
      extend English
    end
    clear!
  end
  
  def parse(words, start_node = :sentence)
    clear!
    @words = words.dup
    @words.freeze
    send(start_node, 0, Hash.new)
    # The result for the network traversal is located in @star.
    return @star
  end
  
  def parse_to_string(words, start_node = :sentence)
    parsed = parse(words, start_node)
    return parsed.inspect.matches_for(/".*?"/).join(" ").gsub("\"", '')
  end
  
  private
    def clear!
      @star = nil
      @words = []
    end
    
    # Tag a word or phrase with a functional role.
    #
    # For example, a single word may be labeled :noun.
    # A phrase (multiple words) may be labeled :noun_phrase.  (Note that each constituent of a phrase
    # should have a tag as well.)
    def tag(marker, constituents)
      # TODO Tag in a different way?  I have to call .last to get the real word...
      tagged = [marker]
      
      constituents.each do |constituent|
        unless constituent.nil?
          # if there's nothing in the register, etc, the value will be nil
          # don't include the nil in the tagging
          tagged << constituent
        end
      end
      
      return tagged
    end
    
    # TODO
    # def choose_arc(arcs, position, registers)
    #   arcs.each do |arc|
    #     begin
    #       arc.call(position, registers)
    #     rescue Ungrammatical
    #       # Move onto the next one
    #     end
    #   end
    #   
    #   raise Ungrammatical
    # end
    
    # Set a given register in the hash given as an argument.  The value that gets assigned
    # to the key is specified in the optional 'extras' hash.  By default, the tag is the same
    # as the destination register (register_name) and the content is the word at the given 
    # position.
    def set_register(register_name, position, registers, extras = {})
      # TODO I'm pretty sure there's an easier way to handle the argument hash
      if extras[:tag]
        tag = extras[:tag]
      else
        tag = register_name
      end
      
      if extras[:content]
        content = extras[:content]
      else
        content = @words[position]
      end
      
      registers[register_name] = tag(tag, content)
    end
    
    def at_last_word?(position)
      # puts("in at_last_word?")
      if !@words[position].nil?
        # puts("failing...")
        raise Ungrammatical
      else
        return @words.length == position
      end
    end
    
    def in_category?(category, position)
      word = @words[position]
      return (!word.nil? and word.send("#{category}?"))
    end
    
    def exact_word?(exact_word, position)
      word = @words[position]
      if word.nil? # if we're checking for a position outside the length of @words
        raise Ungrammatical
      else
        return word == exact_word
      end
      # word = @words.at(position)
      # return (!word.nil? and word == exact_word)
    end
    
    def follow_arc_to(node_name, position, registers)
      send(node_name, position + 1, registers.dup)
    end
    
    def jump_to(node_name, position, registers)
      send(node_name, position, registers.dup)
    end
    
    def push(node_name, position, registers, extras)
      # TODO I'm pretty sure there's an easier way to handle the argument hash
      if extras[:into].nil? or extras[:next].nil?
        raise "You must give :into and :next for the 'extra' hash"
      end
      
      destination_register = extras[:into]
      next_node = extras[:next]
      
      # Traverse the subnetwork...
      send(node_name, position, registers.dup)
      
      # The result for the subnetwork traversal is located in @star.
      registers[destination_register] = @star.dup
      position += registers[destination_register].inspect.number_in_quotes
      
      # Move along to the next node
      send(next_node, position, registers.dup)
    end
    
    def pop(content)
      @star = content
    end
end