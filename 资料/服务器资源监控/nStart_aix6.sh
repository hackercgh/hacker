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
echo "##          Nmon��ؽű�          ##"
echo "####################################"
read file_ser?"�������������:"
###########################################
Tday=$(date +%y%m%d)
file_path="./result/test:$Tday/"	
#file_ip=`hostname|xargs host|awk '{print $3}'`
file_ip=`netstat -in|awk '{print $4}'|grep 30.3|sort|head -1`
file_time=$(date +%Y%m%d%H%M)
file_format=".nmon"
path_log=$file_path$file_ser-$file_ip-$file_time$file_format
###########################################
read ok?"�Ƿ�ʹ��Ĭ�ϲ�����Ĭ�ϼ��${second}�룬ȡֵ${count}�� <y/n>:"
while [ $ok != "y" -a $ok != "Y" -a $ok != "n" -a $ok != "N" ]
do
       read ok?"�Ƿ�ʹ��Ĭ�ϲ�����Ĭ��ÿ${second}�룬ȡֵ${count}�� <y/n>:"
done
if [ $ok = "n" -o $ok = "N" ];then

        read second_new?"��������ʱ��:"
	read count_new?"������ȡֵ����:"

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
read ok?"�Ƿ�ʼ��<y/n>:"
while [ $ok != "y" -a $ok != "Y" -a $ok != "n" -a $ok != "N" ]
do
   read ok?"�Ƿ�ʼ��<y/n>:"
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
echo "�ѿ�ʼ��أ�"
exit 0
