class Array
  def inspect_as_tree(indentation = 4, level = 0)
    tree = ""
    
    self.each do |item|
      if item.respond_to?(:inspect_as_tree)
        tree << item.inspect_as_tree(indentation, level + indentation)
      else
        tree << "#{" " * level}#{item.inspect}\n"
      end
    end
    
    return tree
  end
end