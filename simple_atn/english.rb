# there might still be some issues with things that don't raise Ungrammatical correctly
module English
  private
    def sentence(position, registers)
      push(:noun_phrase, position, registers, :into => :subject, :next => :sentence__subject)
    end
    
    def sentence__subject(position, registers)
      if in_category?(:verb, position)
        set_register(:verb, position, registers)
        follow_arc_to(:verb_phrase__verb, position, registers)
      else
        raise Ungrammatical
      end
    end
    
    def verb_phrase__verb(position, registers)
      if in_category?(:past_participle, position) and "was" == registers[:verb].last # last because of the tagging
        # Passive voice
        registers[:object] = registers[:subject]
        registers.delete(:subject)
        set_register(:verb, position, registers, :content => @words[position].preterite)
        follow_arc_to(:verb_phrase__verb, position, registers)
        # TODO arc 9
      else
        # TODO transitive verb
        begin
          push(:noun_phrase, position, registers, :into => :object, :next => :sentence__verb_phrase)
        rescue Ungrammatical # this is necessary whenever there is a push followed by another arc
          jump_to(:sentence__verb_phrase, position, registers)
        end
      end
    end
    
    def sentence__verb_phrase(position, registers)
      # puts("@words: #{@words.inspect}")
      # puts("position: #{position.inspect}")
      # puts("@words.at(position): #{@words.at(position).inspect}")
      # if at_last_word?(position)
      #   @star = tag(:sentence, registers[:subject], registers[:verb], registers[:object])
      # else
      #   if exact_word?("by", position)
      #     follow_arc_to(:sentence__by, position, registers)
      #   else
      #     raise Ungrammatical
      #   end
      # end
      begin
        if at_last_word?(position)
          pop(tag(:sentence, [registers[:subject], registers[:verb], registers[:object]]))
        end
      rescue Ungrammatical
        # puts("Coming to the rescue!")
        if exact_word?("by", position)
          follow_arc_to(:sentence__by, position, registers)
        else
          raise Ungrammatical
        end
      end
    end
    
    def sentence__by(position, registers)
      # puts("in sentence__by")
      if registers[:subject].nil?
        # Passive voice
        push(:noun_phrase, position, registers, :into => :subject, :next => :sentence__verb_phrase)
      else
        raise Ungrammatical
      end
    end
    
    def noun_phrase(position, registers)
      if in_category?(:determiner, position)
        set_register(:determiner, position, registers)
        follow_arc_to(:noun_phrase__determiner, position, registers)
      else
        begin
          jump_to(:noun_phrase__determiner, position, registers)
        rescue Ungrammatical
          if in_category?(:pronoun, position)
            set_register(:noun, position, registers)
            follow_arc_to(:noun_phrase__noun, position, registers)
          else
            raise Ungrammatical
          end
        end
      end
    end
    
    def noun_phrase__determiner(position, registers)
      if in_category?(:adjective, position)
        set_register(:adjective, position, registers, :content => [registers[:adjective], @words[position]])
        follow_arc_to(:noun_phrase__determiner, position, registers)
      else
        if in_category?(:present_participle, position)
          set_register(:adjective, position, registers, :content => [registers[:adjective], @words[position]])
          follow_arc_to(:noun_phrase__determiner, position, registers)
        else
          if in_category?(:noun, position)
            set_register(:noun, position, registers)
            follow_arc_to(:noun_phrase__noun, position, registers)
          else
            raise Ungrammatical
          end
        end
      end
    end
    
    # TODO
    # def noun_phrase__determiner(position, registers)
    #   arcs = []
    #   
    #   arcs << Proc.new do |position, registers|
    #     if in_category?(:adjective, position)
    #       set_register(:adjective, position, registers, :content => [registers[:adjective], @words[position]])
    #       follow_arc_to(:noun_phrase__determiner, position, registers)
    #     end
    #   end
    #   
    #   arcs << Proc.new do |position, registers|
    #     if in_category?(:present_participle, position)
    #       set_register(:adjective, position, registers, :content => [registers[:adjective], @words[position]])
    #       follow_arc_to(:noun_phrase__determiner, position, registers)
    #     end
    #   end
    #   
    #   arcs << Proc.new do |position, registers|
    #     if in_category?(:noun, position)
    #       set_register(:noun, position, registers)
    #       follow_arc_to(:noun_phrase__noun, position, registers)
    #     end
    #   end
    #   
    #   choose_arc(arcs, position, registers)
    # end
    
    def noun_phrase__noun(position, registers)
      begin
        push(:prepositional_phrase, position, registers, :into => :prepositional_phrase, :next => :noun_phrase__noun)
      rescue Ungrammatical
        pop(tag(:noun_phrase, [registers[:determiner], registers[:adjective], registers[:noun], registers[:prepositional_phrase]]))
      end
    end
    
    def prepositional_phrase(position, registers)
      if in_category?(:preposition, position)
        set_register(:preposition, position, registers)
        follow_arc_to(:prepositional_phrase__preposition, position, registers)
      else
        raise Ungrammatical
      end
    end
    
    def prepositional_phrase__preposition(position, registers)
      push(:noun_phrase, position, registers, :into => :object_of_preposition, :next => :prepositional_phrase__noun_phrase)
    end
    
    def prepositional_phrase__noun_phrase(position, registers)
      pop(tag(:prepositional_phrase, [registers[:preposition], registers[:object_of_preposition]]))
    end
end