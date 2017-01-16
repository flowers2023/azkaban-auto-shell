#!/bin/bash
#########################################################################
# Function: 
# Author: DRUNK
# mail: zhangshuangfu@outlook.com
# Created Time: 2017年01月16日 星期一 16时07分46秒
#########################################################################

source ./config.prop

session_ID=''
projectName=''
function __init__(){
  json=`curl -s -k -X POST --data 'action=login&username='${username}'&password='${password} ${url} `
  session_ID=`echo $json |cut -d':' -f3 |cut -d'"' -f2`
  path=`pwd`
  projectName=${path##*/}
  echo -e "projectName:"${projectName}
  echo -e "session_ID:"${session_ID}
}

__init__

function create(){
  echo -e "\n============start to create project============="
  name=$1
  description=$2
  curl -s -k -X POST --data "session.id="${session_ID}"&name="${name}"&description="${description} ${url}/manager?action=create
}

function update(){
  cho -e "\n============start to zip file to ${projectName}.zip ============="
  zip ${projectName}.zip -r ./
  echo -e "\n============start to update project============="
  name=$1
  curl -k -i -H "Content-Type: multipart/mixed" -X POST  \
       --form 'session.id='${session_ID} \
       --form 'ajax=upload'  \
       --form 'file=@'${name}'.zip;type=application/zip'  \
       --form 'project='${name}';type=text/plain'  \
       ${url}/manager
  if [ -n "${projectName}.zip" ]; then
    rm ${projectName}.zip
  fi
}

# 判断类型
action=$1
echo ${action}
if [ "$action" = "--create" ]; then
  create ${projectName} ${projectName}"_defalut"
fi
update ${projectName}

echo -e '\n===========end==========='
