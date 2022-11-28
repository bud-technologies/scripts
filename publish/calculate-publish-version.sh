#!/bin/bash

read -p 'get current image only? (y/n,default n)' onlyCurrent

#read -p 'namespace=' namespace

#[[ -z $namespace ]] && namespace="bud-base-server"

for namespace in bud-base-server bud-handlemq-server budx-base-server;do

    images=`kubectl get pods -n $namespace -o yaml|grep 'image:'|grep 'buddy-images'|awk '{print $2}'|sed 's/397275977064.dkr.ecr.us-west-1.amazonaws.com\/buddy-images\///g'|sed 's/image\://g'|uniq|sort|grep ':v'`
    for image in $images;do
        name=`echo $image|awk -F':' '{print $1}'`
        major=`echo $image|awk -F'.' '{print $1}'`
        minor=`echo $image|awk -F'.' '{print $2}'`
        patch=0
        #echo $name,$major,$minor,$image
        nextMinor=`expr $minor + 1`
        #nextMinor= ((minor++))
        nextVersion="$major.$nextMinor.${patch}_1"
        if [[ "${onlyCurrent}" == "y" ]];then
            echo $image
        else
            echo $image '->' $nextVersion
        fi
    done

done


