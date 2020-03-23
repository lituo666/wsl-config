#!/bin/bash

#设置xtensa-lx106-elf目录
mulu="./xtensa-lx106-elf"
wenjian=$1
#wenjian="xtensa-lx106-elf.tar.bz2"
#判断是什么版本Linux
xitong=$(cat /etc/issue)
xitong=${xitong%% Lin*}
echo "$xitong Linux"

#if [ ! -d $mulu ];then
#    echo "没有找到\"xtensa-lx106-elf\"文件夹"
#    exit
#fi
#echo "找到\"xtensa-lx106-elf\"文件夹"
#if [ ! -d /opt/xtensa-lx106-elf ];then
#    echo "复制到/opt/下"
#    sudo cp -ri $mulu /opt/
#else
#    echo "已有/opt/xtensa-lx106-elf目录"
#fi

if [ ! -f $wenjian ];then
    echo "没有找到xtensa-lx106-elf.tar.bz2"
    exit
fi
echo "找到xtensa-lx106-elf.tar.bz2"
sudo cp xtensa-lx106-elf.tar.bz2 /opt/
cd /opt/
sudo tar -jxvf xtensa-lx106-elf.tar.bz2

if [ ! -d /opt/xtensa-lx106-elf ];then
    echo "没有解压成功"
else
    echo "已有/opt/xtensa-lx106-elf目录"
fi

echo "修改xtensa-lx106-elf目录权限为777"
sudo chmod 777 /opt/xtensa-lx106-elf

#环境变量添加到~/.bashrc
if [ -f ~/.bashrc ];then
    echo "环境变量添加到~/.bashrc"
    cat >> ~/.bashrc <<EOF
    export PATH=/opt/xtensa-lx106-elf/bin:\$PATH
EOF
fi
#如果有也添加到~/.zshrc
if [ -f ~/.zshrc ];then
    echo "环境变量添加到~/.zshrc"
    cat >> ~/.zshrc <<EOF
    export PATH=/opt/xtensa-lx106-elf/bin:\$PATH
EOF
fi

echo "安装必要工具"
sudo apt-get install libtool libc6-dev-i386 python

if false;then
echo "环境变量有 $PATH"

xtensa-lx106-elf-gcc -v
shifou=$?
echo $shifou
if [[ $shifou -ne 0 ]];then
    if [[ $xitong == "Manjaro" ]];then
       echo "请自己解决"
    elif [[ $xitong == "Ubuntu" ]];then
        echo "正在安装需要的"
        sudo apt-get install libtool libc6-dev-i386 python
    fi
fi
fi


echo "请按下方步骤手动操作"
echo "1.请按照实际情况手动复制下方命令运行"
echo 'source ~/.bashrc'
echo 'source ~/.zshrc'
echo "2.然后输入下方指令进行测试"
echo "xtensa-lx106-elf-gcc -v"
echo "3.如果看不到gcc version 并且是Ubuntu系统，则运行下方指令"
echo "sudo apt-get install libtool libc6-dev-i386 python"
echo "-------xtensa-lx106-elf配置完成-------"


