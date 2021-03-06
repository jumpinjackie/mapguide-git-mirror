#!/bin/bash

rm -rf prepared/csmap.git
cp -R pristine/csmap.git prepared/csmap.git
pushd prepared/csmap.git
# This doesn't catch all, but will cover most of the big dictionary files in question
java -jar ../../bfg.jar --convert-to-git-lfs '*.gsb' --no-blob-protection --private
java -jar ../../bfg.jar --convert-to-git-lfs '*.par' --no-blob-protection --private
java -jar ../../bfg.jar --convert-to-git-lfs '*._par' --no-blob-protection --private
java -jar ../../bfg.jar --convert-to-git-lfs '*.bin' --no-blob-protection --private
java -jar ../../bfg.jar --convert-to-git-lfs '*.b' --no-blob-protection --private
java -jar ../../bfg.jar --convert-to-git-lfs '*.GRD' --no-blob-protection --private
java -jar ../../bfg.jar --convert-to-git-lfs 'OSTN*.*' --no-blob-protection --private
# Need to reflog expire at this point
git reflog expire --expire=now --all && git gc --prune=now --aggressive
java -jar ../../bfg.jar --convert-to-git-lfs 'OSGM*.*' --no-blob-protection --private
git reflog expire --expire=now --all && git gc --prune=now --aggressive
git filter-branch --msg-filter "perl -lape 's/#(\d+)/\[https:\/\/trac\.osgeo\.org\/csmap\/ticket\/\$1\]/g'" -- --all
git reflog expire --expire=now --all && git gc --prune=now --aggressive
# Activate LFS
git lfs install
git remote add origin https://github.com/jumpinjackie/cs-map.git
popd
