#!/bin/bash

second=5
count=120
if [ ! -d ./result ]
then
   mkdir ./result
   chmod 755 ./result
fi
###########################################
echo "####################################"
echo "##          Nmon监控脚本          ##"
echo "####################################"
read -p "请输入测试名称:" file_ser
###########################################
Tday=$(date +%y%m%d)
file_path="./result/test:$Tday/"
#file_ip=`hostname -i`	
file_ip=`/sbin/ifconfig |grep 30.3 |awk '{print $2}' | awk -F: '{print $2}'|head -n 1`
#file_ip=`netstat -in|awk '{print $4}'|grep 30.3|sort|head -1`
file_time=$(date +%Y%m%d%H%M)
file_format=".nmon"
path_log=$file_path$file_ser-$file_ip-$file_time$file_format
###########################################
read -p "是否使用默认参数？默认间隔${second}秒，取值${count}次 <y/n>:" ok
while [ $ok != "y" -a $ok != "Y" -a $ok != "n" -a $ok != "N" ]
do
       read -p "是否使用默认参数？默认间隔${second}秒，取值${count}次 <y/n>:" ok
done
if [ $ok = "n" -o $ok = "N" ];then

        read -p "请输入间隔时间:" second_new
	read -p "请输入取值次数:" count_new

	second=$second_new
	count=$count_new
fi
############################################
echo "----------------------------------------------------------->"
echo "记录名称：${file_ser}-${file_ip}-${file_time}+${file_format}"
echo "设置参数：${second}秒间隔,共取值${count}次"
echo "保存目录：${file_path}"
echo "----------------------------------------------------------->"
############################################
read -p "是否开始？<y/n>:" ok
while [ $ok != "y" -a $ok != "Y" -a $ok != "n" -a $ok != "N" ]
do
   read -p "是否开始？<y/n>:" ok
done
if [ $ok = "n" -o $ok = "N" ];then

        exit 0
fi
############################################

if [ ! -d $file_path ]
then
   mkdir $file_path
   chmod 755 $file_path
fi

./nmon -F $path_log -s $second -c $count -t
############################################
echo "已开始监控！"
exit 0