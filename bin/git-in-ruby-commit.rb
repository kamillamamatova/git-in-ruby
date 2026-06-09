#!/usr/bin/env ruby

# bin/git-in-ruby-commit.rb

# Adds the lib directory to the load path so 
# custom files can be required
$LOAD_PATH << File.expand_path("../../lib", __FILE__)

# Provides SHA1 hashing functionality
require "digest"

# Provides time/date functionality
require "time"

# Loads the custom GitInRuby::Object class
require "git-in-ruby/object"

# Path to the .git-in-ruby directory
GIT_IN_RUBY_DIR = "#{Dir.pwd}/.git-in-ruby".freeze

# Path to the staging index file
INDEX_PATH = "#{GIT_IN_RUBY_DIR}/index"

# Default commit message template shown to the user
COMMIT_MESSAGE_TEMPLATE = <<-TXT
# Title
# 
# Body
TXT

# Reads the index file line by line
# Returns an enumerator that can be looped through
def index_files
  File.open(INDEX_PATH).each_line
end

# Converts the flat index into a nested tree structure
# EX:
# Index:
# abc122 README.md
# idk456 src/main.rb
# lol789 src/utils/helper.rb
# Procedures:
# {
#     "README.md" => "abc122",
#     "src" => {
#         "main.rb" => "idk456",
#         "utils" => {
#             "helper.rb" => "lol789"
#         }
#     }
# }
def index_tree
  # Starts w/ an empty hash
  # Builds the tree structure as files are processed
  index_files.each_with_object({}) do |line, tree|
     # Splits each line into its components
     sha, _, path = line.split

     # Breaks the file path into directories
     segments = path.split("/")

     # Walks through each directory level and builds hashes
     segements.reduce(obj) do [memo, s]
      # If this is the final segment, stores the SHA as the file value
      if s == segments.last
        memo[segments.last] = sha

        memo
      else
        # Creates the directory hash if needed
        memo[s] ||= {}

        # Moves deeper into the tree
        memo[s]
      end
    end
  end
end

# 1. Exits w/ error code & message if there are no files to commit
# 2. Creates all the necessary tree objects for the files in the index
# 3. Creates a commit object pointing to the root tree object
# 4. Updates the current branch to point to the commit
# 5. Clears the index