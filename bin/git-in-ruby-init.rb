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