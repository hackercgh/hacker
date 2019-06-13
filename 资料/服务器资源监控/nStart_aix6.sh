#!/bin/sh

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
read file_ser?"请输入测试名称:"
###########################################
Tday=$(date +%y%m%d)
file_path="./result/test:$Tday/"	
#file_ip=`hostname|xargs host|awk '{print $3}'`
file_ip=`netstat -in|awk '{print $4}'|grep 30.3|sort|head -1`
file_time=$(date +%Y%m%d%H%M)
file_format=".nmon"
path_log=$file_path$file_ser-$file_ip-$file_time$file_format
###########################################
read ok?"是否使用默认参数？默认间隔${second}秒，取值${count}次 <y/n>:"
while [ $ok != "y" -a $ok != "Y" -a $ok != "n" -a $ok != "N" ]
do
       read ok?"是否使用默认参数？默认每${second}秒，取值${count}次 <y/n>:"
done
if [ $ok = "n" -o $ok = "N" ];then

        read second_new?"请输入间隔时间:"
	read count_new?"请输入取值次数:"

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
read ok?"是否开始？<y/n>:"
while [ $ok != "y" -a $ok != "Y" -a $ok != "n" -a $ok != "N" ]
do
   read ok?"是否开始？<y/n>:"
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

nmon -F $path_log -s $second -c $count -t
############################################
echo "已开始监控！"
exit 0
