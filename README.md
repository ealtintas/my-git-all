# my-git-all

Automatically run git commands in multiple git repositories

my-git-all is a bash script that takes git commands as its arguments and it runs those commands under all the sub directories which contains a git repository (where a ".git" directory exists).

## Parameters

--dry : dont run the commands actually
--silent  : dont show additional information
--noremote  : dont show remote repository address
--nolocal : dont show local repository adress

## Examples

my-git-all pull   # updates all the git repositories under current directory
my-git-all status
my-git-all status --short
my-git-all --noremote status --short
