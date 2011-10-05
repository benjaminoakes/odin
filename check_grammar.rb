require 'app/controllers/grammar_checker.rb'

begin
  GrammarChecker.check(ARGV[0])
  puts "Output saved to '#{ARGV[0]}.#{GrammarChecker.suffix}'"
rescue ArgumentError => e
  puts "Usage: ruby check_grammar.rb file_name"
  puts "Output saved to file_name.#{GrammarChecker.suffix}"
# TODO find a way to avoid using Errno::* because of readability issues
rescue Errno::EEXIST => e # Output file exists
  print "There is already output saved for the file you're checking.  Overwrite? (y/n) "
  response = $stdin.gets.chomp # without $stdin, Ruby will read the file supplied to to the script
  
  if "y" != response
    exit!
  else
    File.delete("#{ARGV[0]}.#{GrammarChecker.suffix}")
    retry
  end
rescue Errno::ENOENT => e # No such file or directory
  puts e.message
rescue Errno::EISDIR => e # Is a directory
  puts e.message
end