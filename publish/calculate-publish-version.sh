#!/bin/bash

#read -p 'namespace=' namespace

#[[ -z $namespace ]] && namespace="bud-base-server"

for namespace in bud-base-server bud-handlemq-server;do

    images=`kubectl get pods -n $namespace -o yaml|grep 'image:'|grep 'buddy-images'|awk '{print $2}'|sed 's/397275977064.dkr.ecr.us-west-1.amazonaws.com\/buddy-images\///g'|sed 's/image\://g'|uniq|sort|grep 'v1.'`
    for image in $images;do
        name=`echo $image|awk -F':' '{print $1}'`
        major=`echo $image|awk -F'.' '{print $1}'`
        minor=`echo $image|awk -F'.' '{print $2}'`
        patch=0
        #echo $name,$major,$minor,$image
        nextMinor=`expr $minor + 1`
        #nextMinor= ((minor++))
        nextVersion="$major.$nextMinor.${patch}_1"
        echo $image '->' $nextVersion
        #echo $image
    done

done
