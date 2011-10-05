module Dumper
  private
    def heading(string)
      length = string.length + 5
      
      puts "=" * length
      puts string.upcase
      puts "=" * length
      yield
      puts "=" * length
      puts
    end
    
    def section(string)
      puts string
      puts "-" * (string.length + 2)
      yield
      puts
    end
    
    def indent(string, length = 2, character = " ")
      output = ""
      
      string.each_line do |line|
        output << (character * length) + line
      end
      
      return output
    end
    
    def inspect_tree(tree)
      output = ""
      
      tree.each do |branch|
        if branch.class.to_s == "Array" # TODO better way?
          output << indent(inspect_tree(branch))
        else
          output << "#{branch.inspect}\n"
        end
      end
      
      return output
    end
end