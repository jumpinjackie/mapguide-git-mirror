#!/bin/bash
pushd pristine/mapguide.git
svn2git --rebase
popd
