#!/bin/sh

mkdir -p pristine/mapguide.git
cd pristine/mapguide.git
svn2git http://svn.osgeo.org/mapguide --authors ~/svn_authors.txt --metadata --no-minimize-url --exclude '^MgDev\/Oem\/dbxml\/dbxml\/docs.*$'
