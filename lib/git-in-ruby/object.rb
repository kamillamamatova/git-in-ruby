# lib/git-in-ruby/object.rb

# Provides utility methods for working w/ files and directories
require "fileutils"

# git-in-ruby namespace to avoid conflicts w/ Ruby's build in classes & modules
module gitInRuby
  # Stores thr absolute path to the .git-in-ruby directory
  GIT-IN-RUBY_DIR = "#{Dir.pwd}/.git-in-ruby".freeze

  # Stores the path to the objects directory inside .git-in-ruby
  OBJECTS_DIR = "#{GIT-IN-RUBY_DIR}/objects".freeze

  # Represents a git style object stored in .git-in-ruby/objects
  class Object
    # Creates a new object & stores its SHA hash
    def initialize(content)
      @sha = sha
    end

    # Writes the object to disk
    # Accepts a block that determines what content gets written
    def write(&block)
      # Uses the first 2 chars of the SHA as the directory name
      object_dir = "#{OBJECTS_DIR}/#{sha[0..1]}"

      # Creates the directory if it doesn't exist
      FileUtils.mkdir_p object_dir

      # Uses the remaining SHA chars as the filename
      object_path = "#{object_dir}/#{sha[2..-1]}"

      # Opens the object file for writing
      File.open(object_path, "w", &block)
    end

    private
    # Creates a private reader method for @sha
    # Only methods inside this class can access it
    attr_reader :sha
  end
end