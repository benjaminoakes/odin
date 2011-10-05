# word.rb MUST be required before string.rb
require File.dirname(__FILE__) + '/../../lib/word.rb'
require File.dirname(__FILE__) + '/../../lib/string.rb'
require File.dirname(__FILE__)/'..'/'..'/'lib'/'star.rb'
require File.dirname(__FILE__)/'..'/'..'/'lib'/'atn.rb'

class GrammarChecker
  @@suffix = "checked.html"
  
  def self.suffix
    @@suffix
  end
  
  def self.check(file_name)
    @in_file_name = file_name
    @out_file_name = "#{@in_file_name}.#{@@suffix}"
    
    check_file_name
    
    File.open(@in_file_name, "r") do |in_file|
      File.open(@out_file_name, "w") do |out_file|
        
        out_file.puts '<link rel="stylesheet" href="grammar_checker.css" type="text/css" media="screen" />'
        
        while (line = in_file.gets)
          checked = line.check_grammar do |sentence|
            "<span class=\"ungrammatical\">#{sentence}</span>"
            # "<ungrammatical message=\"\" suggestion=\"\">#{sentence}</ungrammatical>"
          end
          
          out_file.puts(checked)
        end
      end
    end
  end
  
  private
    def self.check_file_name
      if @in_file_name.nil?
        raise ArgumentError.new("Nil file name supplied")
      end
      
      if File.exists?(@out_file_name)
        raise Errno::EEXIST
      end
      
      if File.directory?(@in_file_name)
        raise Errno::EISDIR
      end
    end
end
