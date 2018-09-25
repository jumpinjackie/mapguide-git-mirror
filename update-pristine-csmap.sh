#!/bin/bash
pushd pristine/csmap.git
svn2git --rebase
popd
