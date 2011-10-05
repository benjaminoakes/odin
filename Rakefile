require "find"

# TODO switch to using "import"
def require_files(directory)
  Find.find(directory) do |file_name|
    if file_name.match(/.*\.rb$/)
      require file_name
    end
  end
end

# The names of the tasks here are modeled after those in Rails

# TODO add the descriptions back in.  (Removed because they make it so that I have to choose a
# task when running the Rakefile via TextMate.)

task :default => :pre_commit
# desc "The task performed by the pre-commit hook in the Subversion repository."
task :pre_commit => "test" #[:validate_syntax, :unit_test]
task :test => ["test:units", "test:integration", "test:functionals"] # TODO a better way?

namespace "test" do
  # desc "Run the unit tests in 'test/unit/*_test.rb'"
  task :units do
    require 'rake/runtest'
    # Add all the dependencies
    require_files("lib")
    Rake.run_tests "test/unit/*_test.rb"
  end
  
  # desc "Run the integration tests in 'test/integration/*_test.rb'"
  task :integration do
    require 'rake/runtest'
    # Add all the dependencies
    require_files("lib")
    Rake.run_tests "test/integration/*_test.rb"
    Rake.run_tests "test/integration/*/*_test.rb"
  end
  
  # desc "Run the unit tests in 'test/functional/*_test.rb'"
  task :functionals do
    require 'rake/runtest'
    # Add all the dependencies
    require_files("lib")
    require_files("app")
    Rake.run_tests "test/functional/*_test.rb"
  end
end

# TODO
# desc "Validate the syntax of all files."
# task :validate_syntax do
#   puts '--------------------------------------------'
#   puts 'Syntax Errors:'
#   # TODO use "ruby -wc" recursively on all Ruby files
#   puts '--------------------------------------------'
# end
#
# namespace "doc" do
# TODO
# desc "Generate documentation via rdoc"
  # task :odin do
  #  # TODO generate documentation with rdoc
  # end
# end