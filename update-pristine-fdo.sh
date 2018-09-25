#!/bin/bash
pushd pristine/fdo.git
svn2git --rebase
popd
