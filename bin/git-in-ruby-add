#!/usr/bin/env ruby

# SHA1 hashing
require "digest"
# Compression
require "zlib"
# Creates directories recursively
require "fileutils"

# Paths used by the repository
GIT_IN_RUBY_DIR = ".git-in-ruby".freeze
OBJECTS_DIR = "#{GIT_IN_RUBY_DIR}/objects".freeze
INDEX_PATH = "#{GIT_IN_RUBY_DIR}/index"

# Makes sure I'm inside the repository
if !Dir.exist? GIT_IN_RUBY_DIR
    $stderr.puts "Not in git_in_ruby repository"
    exit 1
end

# Gets the file path supplied by the user
path = ARGV.first

# Ensures a file path was provided
if path.nil?
    $stderr.puts "No path specified"
    exit 1
end

# Reads the contents of the file
file_contents = File.read(path)

# Generates a SHA1 hash of the contents
sha = Digest::SHA1.hexdigest(file_contents)

# Compresses the file contents before storing them
blob = Zlib::Deflate.deflate

# Creates git style object directory using first 2 chars of SHA
object_dir = "#{OBJECTS_DIR}/#{sha[0..1]}"

# Creates the directory if it doesn't exist
FileUtils.mkdir_p object_dir

# Remaining chars before the filename
blob_path = "#{object_dir}/#{sha[2..-1]}"

# Stores the compressed blob object
File.open(blob_path, "w") do |file|
    file.print blob
end

# Records the file in the index
File.open(INDEX_PATH, "a") do |file|
    file.puts "#{sha} #{path}"
end