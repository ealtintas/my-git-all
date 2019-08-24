#!/bin/bash

# do multiple git operations on many source directories

COMMAND=""
MODE=""

# idiomatic parameter and option handling in sh 
# SRC: https://superuser.com/questions/186272/check-if-any-of-the-parameters-to-a-bash-script-match-a-string
while test $# -gt 0
do
    case "$1" in
        --dry) echo "Dry-run activated";
			MODE=$MODE"DRYRUN"
            ;;
        --silent) echo "Silent mode activated";
			MODE=$MODE"SILENT"
            ;;
        --nolocal) echo "no-local activated";
			MODE=$MODE"NOLOCAL"
            ;;
        --noremote) echo "no-remote activated";
			MODE=$MODE"NOREMOTE"
            ;;
#        --opt2) echo "option 2"
#            ;;
#        --*) echo "bad option $1"
#            ;;
        *) echo "argument $1"
#			COMMAND="$1"
			COMMAND="$COMMAND $1"
            ;;
    esac
    shift	# take other parameters into account
done

echo "My Git Commands: $COMMAND"

# Yöntem-3
for dir in $(find . -type d -name ".git"); do
	cd "${dir%/*}"
	if [[ $MODE != *"SILENT"* ]]; then
		if [[ $MODE != *"NOLOCAL"* ]]; then
			echo "### LOCAL  : ${dir%/*}"
		fi
		if [[ $MODE != *"NOREMOTE"* ]]; then
			echo "### REMOTE : $(git remote -v | grep '(fetch)$' | cut -f 2)";
		fi
	fi
	if [[ $MODE != *"DRYRUN"* ]]; then
		git $COMMAND
	fi
	cd - > /dev/null; 
done

exit

# Yöntem-2
find . -name ".git" -type d | sed 's/\/.git//' |  xargs -P10 -I{} git -C {} pull

# Yöntem-4
ls | xargs -P10 -I{} git -C {} pull

# Yöntem-5
cd plugins
for f in cms admin chart
do 
  cd $f && git pull origin master && cd ..
done

# Yöntem-6
for i in */.git; do ( echo $i; cd $i/..; git pull; ); done

# Yöntem-1
find . -maxdepth 1 -type d -exec git --git-dir={}/.git --work-tree=$PWD/{} pull origin master \;



#Refs:
#https://stackoverflow.com/questions/3497123/run-git-pull-over-all-subdirectories
#https://stackoverflow.com/questions/17571344/recursive-git-push-pull

#Hazır scriptler
#https://github.com/mnagel/clustergit
#https://github.com/DariuszOstolski/rgit
#https://github.com/kenglxn/gitr/blob/master/README.md

#Hazır paketler
#mr - Multiple Repository management tool (transitional package)
#myrepos - tool to manage all your version control repos
