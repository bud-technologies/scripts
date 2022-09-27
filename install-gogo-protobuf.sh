#!/bin/bash

echo "如果提示需要在module下运行，切换到含有go.mod的目录下即可"

read -p 'is your go version > 1.16? (y/n,default n)' flag
get='go get'
[[ "$flag" == 'y' ]] && get="go get -d"

echo $flag,$get

$get github.com/gogo/protobuf/protoc-gen-gofast

# 下面这些是protoc-gen-gofast的升级版，支持插件
# 减少指针加快垃圾回收
# 生成更多代码
for name in "" fast faster slick;do
    $get github.com/gogo/protobuf/protoc-gen-gogo$name
done

$get github.com/gogo/protobuf/gogoproto

# 速度更快，定制化

for name in proto gogoproto;do
    # 区别在于下载的proto是放在GOPATH/src下还是GOPATH/pkg下
    # 官方的文档中按照GO111MODULE=off处理的
    GO111MODULE=off $get github.com/gogo/protobuf/$name
    GO111MODULE=on $get github.com/gogo/protobuf/$name
done

$get github.com/gogo/protobuf/jsonpb

# 这里有个需要注意的点：如果开启了GO111MODULE则指定的src/xxx/protobuf找不到，因为我们在go get时放在了pkg下面且有版本管理
# 目前官方暂未解决，所以这里在安装时设置GO111MODULE来兼容
