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
echo "##          Nmon��ؽű�          ##"
echo "####################################"
read -p "�������������:" file_ser
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
read -p "�Ƿ�ʹ��Ĭ�ϲ�����Ĭ�ϼ��${second}�룬ȡֵ${count}�� <y/n>:" ok
while [ $ok != "y" -a $ok != "Y" -a $ok != "n" -a $ok != "N" ]
do
       read -p "�Ƿ�ʹ��Ĭ�ϲ�����Ĭ�ϼ��${second}�룬ȡֵ${count}�� <y/n>:" ok
done
if [ $ok = "n" -o $ok = "N" ];then

        read -p "��������ʱ��:" second_new
	read -p "������ȡֵ����:" count_new

	second=$second_new
	count=$count_new
fi
############################################
echo "----------------------------------------------------------->"
echo "��¼���ƣ�${file_ser}-${file_ip}-${file_time}+${file_format}"
echo "���ò�����${second}����,��ȡֵ${count}��"
echo "����Ŀ¼��${file_path}"
echo "----------------------------------------------------------->"
############################################
read -p "�Ƿ�ʼ��<y/n>:" ok
while [ $ok != "y" -a $ok != "Y" -a $ok != "n" -a $ok != "N" ]
do
   read -p "�Ƿ�ʼ��<y/n>:" ok
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
echo "�ѿ�ʼ��أ�"
exit 0