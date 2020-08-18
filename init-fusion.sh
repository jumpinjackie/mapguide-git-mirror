#!/bin/sh

mkdir -p pristine/fusion.git
cd pristine/fusion.git
svn2git https://svn.osgeo.org/fusion --authors ~/svn_authors.txt --metadata --no-minimize-url
