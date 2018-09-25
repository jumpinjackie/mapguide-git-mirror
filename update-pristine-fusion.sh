#!/bin/bash
pushd pristine/fusion.git
svn2git --rebase
popd
