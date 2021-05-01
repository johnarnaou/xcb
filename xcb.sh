#!/bin/bash
project_name=$(ls | grep 'xcodeproj')
ruby ~/.xcb/xcb.rb "$PWD" "$project_name" $1 "$(id -F)" $2 $3
