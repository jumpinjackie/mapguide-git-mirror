#!/bin/bash

rm -rf prepared/mapguide.git
cp -R pristine/mapguide.git prepared/mapguide.git
pushd prepared/mapguide.git
java -jar ../../bfg.jar --protect-blobs-from master,3.1 --delete-folders Maestro --strip-blobs-bigger-than 5M --private
git filter-branch --msg-filter "perl -lape 's/#(\d+)/\[https:\/\/trac\.osgeo\.org\/mapguide\/ticket\/\$1\]/g'" -- --all
# There is a whole bunch of dbxml docs we don't care to preserve
git filter-branch -f --tree-filter 'rm -rf MgDev/Oem/dbxml/db-4.8.26/docs' HEAD
git filter-branch -f --tree-filter 'rm -rf MgDev/Oem/dbxml/dbxml/docs' HEAD
git filter-branch -f --tree-filter 'rm -rf MgDev/Oem/dbxml/xqilla/docs' HEAD
git filter-branch -f --tree-filter 'rm -rf MgDev/Oem/dbxml/xerces-c-src/doc' HEAD
git reflog expire --expire=now --all && git gc --prune=now --aggressive
# Prune Maestro Branches
git branch | grep [Mm]aestro | xargs -L1 git branch -D
git tag -l | grep MAESTRO | xargs -L1 git tag -d
git remote add origin https://github.com/jumpinjackie/mapguide.git
# Add extras
cp ../../overlays/mapguide/README.md .
git add README.md
git submodule add https://github.com/jumpinjackie/cs-map MgDev/Oem/CsMap
git submodule add https://github.com/jumpinjackie/fusion MgDev/Oem/fusion
git commit -m "Add custom overlay for git-converted repo"
popd
