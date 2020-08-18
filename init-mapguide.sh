#!/bin/sh

mkdir -p pristine/mapguide.git
cd pristine/mapguide.git
svn2git https://svn.osgeo.org/mapguide --authors ~/svn_authors.txt --metadata --no-minimize-url
