#!/bin/bash

rm -rf prepared/fusion.git
cp -R pristine/fusion.git prepared/fusion.git
pushd prepared/fusion.git
git filter-branch --msg-filter "perl -lape 's/#(\d+)/\[https:\/\/trac\.osgeo\.org\/fusion\/ticket\/\$1\]/g'" -- --all
git reflog expire --expire=now --all && git gc --prune=now --aggressive
git remote add origin https://github.com/jumpinjackie/fusion.git
# Add extras
cp ../../overlays/fusion/.gitignore .
popd
