#!/bin/sh

mkdir -p pristine/csmap.git
cd pristine/csmap.git
svn2git https://svn.osgeo.org/metacrs/csmap --authors ~/svn_authors.txt --metadata --no-minimize-url
