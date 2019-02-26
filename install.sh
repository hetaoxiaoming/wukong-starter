#!/bin/bash

PWD=`pwd`

install_homebrew(){
    os=$1
    echo "正在为您安装homebrew"
    if [[ $os == "macos" ]]
    then        
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
        test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
        test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
        test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
        echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
    fi
}

install_starter(){
    echo "正在为您安装wukong-starter"
    brew install portaudio sox ffmpeg swig
    sudo pip3 install --upgrade pip
    sudo pip3 install pyaudio
    cd ~
    wget http://hahack-1253537070.file.myqcloud.com/misc/snowboy.tar.bz2
    tar -xvjf snowboy.tar.bz2
    rm snowboy.tar.bz2
    cd ~/snowboy/swig/Python3
    make
    sudo cp _snowboydetect.so ${PWD}/snowboy/
    sudo rm -rf ~/snowboy
    sudo chmod -R 777 ${PWD}
clear
echo "wukong-starter 已安装完成!"

} 


clear
echo "---------- 欢迎使用 wukong-starter 一键安装脚本 ----------"
system=$(uname -a)
os_name=(${system// / })
if [ ${os_name[0]} == "Darwin" ]
then
    read -p "您的系统是否为 MacOS? [Y/n]: " confirm
    if [[ ${confirm} != "Y" && ${confirm} != "y" && ${confirm} != "" ]]
    then
        echo "系统检测错误，已退出安装，请反馈给作者"
        exit
    else
        install_homebrew "macos"
        install_starter
    fi
elif [[ ${os_name[0]} == "Linux" && ${os_name[2]} =~ "Microsoft" ]]
then   
    read -p "您的系统是否为win10子系统? [Y/n]:" confirm    
    if [[ ${confirm} != "Y" && ${confirm} != "y" && ${confirm} != "" ]]
    then                 
        echo "系统检测错误，已退出安装，请反馈给作者"
        exit
    else
        install_homebrew "win10"
        install_starter
    fi
elif [[ ${os_name[0]} == "Linux" && ${os_name[1]} != "raspberrypi" ]]
then
    if [[ ${confirm} != "Y" && ${confirm} != "y" && ${confirm} != "" ]]
    then                                                                                                                   
        echo "系统检测错误，已退出安装，请反馈给作者"
        exit
    else
        install_homebrew "linux"
        install_starter
    fi
fi
