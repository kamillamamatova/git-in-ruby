# Gets the first command line argument and stores the rest in args
command, *args = ARGV

# If the user didn't provide a command
if command.nil?
  # Prints a usage message and exits with a non 0 status code
  $stderr.puts "Usage: git-in-ruby <command> [<args>]"
  exit 1
end

# Builds the full path to the command executable
path_to_command = File.expand_path("git-in-ruby-#{command}", __dir__)

# Checks whether the command file actually exists
if !File.exist? path_to_command
  # Tells the user the command wasn't found
  $stderr.puts "No such command"
  exit 1
end

# Replaces the current Ruby process w/ the command executable
# The *args operator expands the array into separate arguments
exec path_to_command, *args