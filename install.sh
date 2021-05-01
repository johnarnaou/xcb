#!/bin/bash

# install gem xcodeproj
echo "Install dependencies";

sudo gem install xcodeproj;

# create directories and move files
echo "Moving files into place";

rm -rf ~/.xcb;
mkdir ~/.xcb;

cp xcb.rb ~/.xcb/xcb.rb;
cp xcb.sh ~/.xcb/xcb.sh;
cp -R template ~/.xcb/template;

echo "Fixing permissions..."

chmod u+x ~/.xcb/xcb.sh;

echo "Done!";

open ~/.xcb;
