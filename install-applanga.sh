#!/bin/bash

version=1.0.75
read -p "version(default $version): " v

[[ ! -z $v ]] && version=$v
wget https://github.com/applanga/applanga-cli/releases/download/${version}/applanga_osx.tar.gz
