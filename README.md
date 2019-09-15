# my-git-all.sh

## Description

Automatically run git commands in multiple git repositories

## Info

This is a simple bash script which takes git commands as its arguments and it runs those commands under all the sub directories which contains a git repository (where a ".git" directory exists).

If you have many git repositories you can group them under directories. This way you can run the same git command on all those repositories at once using this script which will save your time. 

There are some optional parameters to control the actions of this script.

I have written this script to manage my local git repositories easly. It saved me a lot of time. I hope it will be usefull for you too.

## Usage

```
usage: my-git-all.sh [--optional-parameter] [actual git command]

optional parameters:

  --dry : dont run the commands actually just show information
  --silent  : dont print any additional information
  --showremote  : show remote repository address (default action dont show)
  --nolocal : dont show local repository adress (default actio show local repo adress)
```

## Examples

```
my-git-all pull   # updates all the git repositories under current directory
my-git-all status
my-git-all status --short
my-git-all --noremote status --short
```
