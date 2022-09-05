#!/bin/bash

read -p 'buddy-global root: ' root
read -p 'module grep: ' ptn
for subroot in buddy_backend buddy_cgi;do
    cmd="find $root -name Dockerfile|grep $subroot"
    if [[ ! -z $ptn ]];then
        cmd="$cmd|grep $ptn"
    fi
    #echo $cmd
    modules=`eval $cmd`
    for mod in $modules;do
        #echo $mod
        proot=`dirname $mod`
        pname=`basename $proot`
        imageName=`echo $pname|sed 's/\_/\-/g'|tr 'A-Z' 'a-z'`
        #echo $pname,$imageName
        vs=`cat ./publish-todos.txt|grep $imageName|awk -F'>' '{print $2}'`
        vs=`echo $vs|sed 's/v//g'`
        cmd="cd $proot && make all VS=$vs"
        echo $cmd
    done
done
