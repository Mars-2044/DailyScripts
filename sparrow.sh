#!/bin/bash

if [ $# -lt 1 ]; then
  echo "Usage: $0 stop/start ..."
  exit 1
fi

action=$1

server_list=("loginserver" 
	    "crossserver1"
	    "crossserver2"
	    "matchserver"
	    "battleserver1"
	    "gameserver1"
)

port_list=(4100 9111 9200 8100 7100 6100)
success_info="${action} 成功"
failed_info="${action} 失败"

StarStop(){
  for i in ${server_list[@]};do
    scripts_name=`echo $i |sed 's/[0-9]*$//'| sed 's/\(.\)\(server*\)/\1_\2/'|awk '{print $1".sh"}'`
    cd $i && sh $scripts_name $action > /dev/null 2>&1 &
  done
}

CheckProcess(){
  for i in "${!port_list[@]}";do
    netstat -tunlp |grep -q ${port_list[i]} 
    if [ $? -${Type} 0 ];then
      echo -e "${server_list[i]}  \033[31m${1}\033[0m"
      exit 1
    fi
  done
  echo -e "\033[32m${success_info}\033[0m"
}

if [ $action = "start" ];then
  StarStop
  sleep 30
  Type="ne"
  CheckProcess $failed_info
elif [ $action = "stop" ];then
  StarStop
  sleep 330
  Type="eq"
  CheckProcess $failed_info
elif [ $action = "stopnow" ];then
  StarStop
  sleep 30
  Type="eq"
  CheckProcess $failed_info
fi
