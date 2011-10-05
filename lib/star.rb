class Star < Array
  def initialize(*elements)
    @current = 0
    super(elements)
  end
  
  def current
    return self.[](@current)
  end
  
  def next
    unless last_word?
      @current += 1
    else
      raise FragmentException.new("Fragment (consider revising)")
    end
  end
  
  private
    def last_word?
      (length - 1) == @current
    end
end