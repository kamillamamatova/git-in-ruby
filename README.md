# git-in-ruby

I don't have ruby, so to install it on mac:
brew install ruby

and download a ruby extension on vscode

It's also .rb

I regret naming this git-in-ruby because I have to use that name so many times, it's not efficient

Apparently ruby doesn't let u have hyphens in module/class names, so module "git-in-ruby" wasn't good
Oh it also needs to start w/ an upper case letter

Building the tree is done in 2 passes. 1st index is converted into a hash structure representing the file tree. This structure is converted to tree objects on the filesystem. Both steps are done recursively.