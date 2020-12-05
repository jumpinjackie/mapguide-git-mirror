#!/bin/sh

mkdir -p pristine/fusion.git
cd pristine/fusion.git || exit
svn2git https://svn.osgeo.org/fusion --authors ~/svn_authors.txt --metadata --no-minimize-url
while [ $? -ne 0 ]
do
    echo "Repo import was interrupted. Retrying in 5s"
    sleep 5s
    svn2git https://svn.osgeo.org/fusion --authors ~/svn_authors.txt --metadata --no-minimize-url
done
