#!/bin/bash

read -p 'what is your shell: ' shell

$shell < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
