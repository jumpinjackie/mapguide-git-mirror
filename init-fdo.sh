#!/bin/sh

mkdir -p pristine/fdo.git
cd pristine/fdo.git
svn2git http://svn.osgeo.org/fdo --authors ~/svn_authors.txt --metadata --no-minimize-url
