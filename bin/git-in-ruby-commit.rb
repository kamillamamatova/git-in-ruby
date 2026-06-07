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
