#!/usr/bin/env ruby

# Defines the name of the main git-in-ruby directory
GIT_IN_RUBY_DIR = ".git-in-ruby".freeze # .freeze prevents the string from being modified later

# Defines the path to the objects directory inside .git-in-ruby
OBJECTS_DIR = "#{GIT_IN_RUBY_DIR}/objects".freeze

# Defines the path to the refs directory inside .git-in-ruby
REFS_DIR = "#{GIT_IN_RUBY_DIR}/refs".freeze

# Checks if a .git-in-ruby directory already exists
if Dir.exists? GIT_IN_RUBY_DIR
  # Prints an error message to standard error
  $stderr.puts "Existing git-in-ruby project"
  exit 1
end

# Method that creates the objects directory structure
def build_objects_dir
  # Creates .git-in-ruby/objects
  Dir.mkdir OBJECTS_DIR

  # Creates .git-in-ruby/objects/info
  Dir.mkdir "#{OBJECTS_DIR}/info"

  # Creates .git-in-ruby/objects/pack
  Dir.mkdir "#{OBJECTS_DIR}/pack"
end

# Method that creates the refs directory structure
def build_refs_dir
  # Create .git-in-ruby/refs
  Dir.mkdir REFS_DIR

  # Creates .git-in-ruby/refs/heads
  Dir.mkdir "#{REFS_DIR}/heads"

  # Creates .git_in_ruby/refs/tags
  Dir.mkdir "#{REFS_DIR}/tags"
end

# Method that creates the HEAD file
def initialize_head
  # Opens .git-in-ruby/HEAD for writing
  # If it doesn't exist, ruby will create it
  File.open("#{GIT_IN_RUBY_DIR}/HEAD", "w") do |file|
    # Writes the default branch reference into HEAD
    # This means HEAD points to refs/heads/master
    file.puts "ref: refs/heads/master"
  end
end

# Creates the main .git-in-ruby directory
Dir.mkdir GIT_IN_RUBY_DIR

# Creates the objects folder structure
build_objects_dir

# Creates the refs folder structure
build_refs_dir

# Initializes the HEAD file
initialize_head

# Prints a success message to standard output
$stdout.puts "git-in-ruby initialized in #{GIT_IN_RUBY_DIR}"