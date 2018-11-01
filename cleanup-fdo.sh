#!/bin/bash

rm -rf prepared/fdo.git
cp -R pristine/fdo.git prepared/fdo.git
pushd prepared/fdo.git
java -jar ../../bfg.jar --protect-blobs-from master,4.1 --strip-blobs-bigger-than 5M --private
git filter-branch --msg-filter "perl -lape 's/#(\d+)/\[https:\/\/trac\.osgeo\.org\/fdo\/ticket\/\$1\]/g'" -- --all
git reflog expire --expire=now --all && git gc --prune=now --aggressive
git remote add origin https://github.com/jumpinjackie/fdo.git
cp ../../overlays/fdo/appveyor.yml .
cp ../../overlays/fdo/.travis.yml .
cp ../../overlays/fdo/README.md .
git add appveyor.yml .travis.yml README.md
git commit -m "Add custom overlay for git-converted repo"
popd
