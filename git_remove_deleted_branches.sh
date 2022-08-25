#!/usr/bin/env bash

if [ "$1" = "-h" ];
  then
      echo ""
      echo "git_remove_deleted_branches"
      echo ""
      echo "Use in a git repository"
      echo "Removes all the local branches that does not have a remote reference anymore"
      echo "The script does not remove the local branches not pushed to remote"
      echo "The script will fail if you try to remove your active branch"
      exit 0
fi

git fetch -p 
echo "Delete branches..."
for branch in $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'); 
do 
  git branch -D $branch; 
done

