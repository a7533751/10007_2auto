#!/bin/bash

function update_readme(){
if test -f `pwd`/README.md ;then

test -f `pwd`/all && count_all="$(cat `pwd`/all 2>/dev/null | tr '\r\n' '\n' | sed '/^#/d;/^[[:space:]]*$/d' | wc -l)" || count_all="未知"

cat << key > `pwd`/README.md
## 去广告订阅自动更新
## [English](./README_en.md)

## 统计
\`\`\`
累积拦截域名: ${count_all}
\`\`\`

## PC 分支 仅做测试
### 将\`127.0.0.1\`替换成adguard的\`94.140.14.33\`，企图规避一些问题，例如反复请求引起的耗电。

## SwitchHosts
### 您可以选择 [SwitchHosts](https://github.com/oldj/SwitchHosts/releases) 对hosts进行管理。

## 订阅

| **名称** | **链接** | **镜像链接** |
| :-- | :-- | :-- |
| **PC规则** | [订阅链接](https://raw.githubusercontent.com/lingeringsound/10007_auto/PC_For_Test/all) | [Gitlink镜像](https://code.gitlink.org.cn/api/v1/repos/keytoolazy/10007_auto/raw/all?ref=PC_For_Test) |

## **[捐赠地址](https://github.com/lingeringsound/10007)**
key
cat << key > `pwd`/README_en.md
## REmove Ads Host
## [中文](./README.md)

## count
\`\`\`
All of rules: ${count_all}
\`\`\`

## SwitchHosts
### maybe you will need [SwitchHosts](https://github.com/oldj/SwitchHosts/releases) to manager hosts.

| **name** | **links** |
| :-- | :-- |
| **PC rules** | [Subscription link](https://raw.githubusercontent.com/lingeringsound/10007_auto/PC_For_Test/all) |

## **[Donate](https://github.com/lingeringsound/10007)**

key
fi
}


update_readme

