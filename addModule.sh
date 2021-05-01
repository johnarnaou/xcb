#!/bin/bash
project_name=$(ls | grep 'xcodeproj')
ruby ~/.scripts/boilerplate/addModule.rb "$PWD" "$project_name" $1 $2 "$(id -F)"
