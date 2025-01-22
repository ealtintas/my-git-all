#!/usr/bin/env bash

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
        --silent) echo "SILENT mode activated";
			MODE=$MODE"SILENT"
            ;;
        --nolocal) echo "NOLOCAL activated";
			MODE=$MODE"NOLOCAL"
            ;;
        --showremote) echo "SHOWREMOTE activated";
			MODE=$MODE"SHOWREMOTE"
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
		if [[ $MODE = *"SHOWREMOTE"* ]]; then
			echo "### REMOTE : $(git remote -v | grep '(fetch)$' | cut -f 2)";
		fi
	fi
	if [[ $MODE != *"DRYRUN"* ]]; then
		git $COMMAND
	fi
	cd - > /dev/null; 
done


# Git repoları üzerinde calismak için yöntemler
	#find . -name ".git" -type d | sed 's/\/.git//' |  xargs -P10 -I{} git -C {} pull
	#ls | xargs -P10 -I{} git -C {} pull
	#for i in */.git; do ( echo $i; cd $i/..; git pull; ); done
	#find . -maxdepth 1 -type d -exec git --git-dir={}/.git --work-tree=$PWD/{} pull origin master \;

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
