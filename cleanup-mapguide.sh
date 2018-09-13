#!/bin/sh

rm -rf prepared/mapguide.git
cp -R pristine/mapguide.git prepared/mapguide.git
pushd prepared/mapguide.git
java -jar bfg.jar --protect-blobs-from master,3.1 --delete-folders Maestro --strip-blobs-bigger-than 5M
git filter-branch --msg-filter "perl -lape 's/#(\d+)/\[https:\/\/trac\.osgeo\.org\/mapguide\/ticket\/\$1\]/g'" -- --all
git reflog expire --expire=now --all && git gc --prune=now --aggressive
# Prune Maestro Branches
git branch | grep [Mm]aestro | xargs -L1 git branch -D
git tag -l | grep MAESTRO | xargs -L1 git tag -d
git remote add origin https://github.com/jumpinjackie/mapguide.git
popd