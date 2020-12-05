#!/bin/sh

mkdir -p pristine/csmap.git
cd pristine/csmap.git || exit
svn2git https://svn.osgeo.org/metacrs/csmap --authors ~/svn_authors.txt --metadata --no-minimize-url
while [ $? -ne 0 ]
do
    echo "Repo import was interrupted. Retrying in 5s"
    sleep 5s
    svn2git https://svn.osgeo.org/metacrs/csmap --authors ~/svn_authors.txt --metadata --no-minimize-url
done
