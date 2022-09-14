#!/bin/bash
[[ $(id -u) != 0 ]] && echo -e "请使用root权限运行安装脚本" && exit 1

cmd="apt-get"
if [[ $(command -v apt-get) || $(command -v yum) ]] && [[ $(command -v systemctl) ]]; then
    if [[ $(command -v yum) ]]; then
        cmd="yum"
    fi
else
    echo "此脚本不支持该系统" && exit 1
fi

install() {
    if [ -d "/root/miner_proxy" ]; then
        echo -e "您已安装了该软件,如果确定没有安装,请输入rm -rf /root/miner_proxy" && exit 1
    fi
    if screen -list | grep -q "minerProxy"; then
        echo -e "检测到您已启动了minerProxy,请关闭后再安装" && exit 1
    fi

    $cmd update -y
    $cmd install curl wget screen -y
    mkdir /root/miner_proxy

<<<<<<< HEAD
    wget https://cdn.jsdelivr.net/gh/Char1esOrz/minerProxy@master/release/v6.0.3/minerProxy_v6.0.3_linux_arm64 -O /root/miner_proxy/minerProxy
=======
    wget https://cdn.jsdelivr.net/gh/Char1esOrz/minerProxy@master/release/v6.0.1/minerProxy_v6.0.1_linux_arm64 -O /root/miner_proxy/minerProxy
>>>>>>> parent of 6bb186b (修复专业矿机发送空数据包导致刷屏的问题)

    chmod 777 /root/miner_proxy/minerProxy

    wget https://cdn.jsdelivr.net/gh/Char1esOrz/minerProxy@master/scripts/run.sh -O /root/miner_proxy/run.sh
    chmod 777 /root/miner_proxy/run.sh
    echo "如果没有报错则安装成功"
    echo "正在启动..."
    screen -dmS minerProxy
    sleep 0.2s
    screen -r minerProxy -p 0 -X stuff "cd /root/miner_proxy"
    screen -r minerProxy -p 0 -X stuff $'\n'
    screen -r minerProxy -p 0 -X stuff "./run.sh"
    screen -r minerProxy -p 0 -X stuff $'\n'
    sleep 3s
    cat /root/miner_proxy/password.txt
    echo "请输入 cat /root/miner_proxy/password.txt 账号密码"
    echo "输入 cat /root/miner_proxy/后台地址.txt 查看后台地址和端口"
    echo "已启动web后台 您可运行 screen -r minerProxy 查看程序输出"
}

uninstall() {
    read -p "是否确认删除minerProxy[yes/no]：" flag
    if [ -z $flag ]; then
        echo "输入错误" && exit 1
    else
        if [ "$flag" = "yes" -o "$flag" = "ye" -o "$flag" = "y" ]; then
            screen -X -S minerProxy quit
            rm -rf /root/miner_proxy
            echo "卸载minerProxy成功"
        fi
    fi
}

update() {
    if screen -list | grep -q "minerProxy"; then
        screen -X -S minerProxy quit
    fi
    rm -rf /root/miner_proxy/minerProxy

<<<<<<< HEAD
    wget https://cdn.jsdelivr.net/gh/Char1esOrz/minerProxy@master/release/v6.0.3/minerProxy_v6.0.3_linux_amd64 -O /root/miner_proxy/minerProxy
=======
    wget https://cdn.jsdelivr.net/gh/Char1esOrz/minerProxy@master/release/v6.0.1/minerProxy_v6.0.1_linux_amd64 -O /root/miner_proxy/minerProxy
>>>>>>> parent of 6bb186b (修复专业矿机发送空数据包导致刷屏的问题)

    chmod 777 /root/miner_proxy/minerProxy

    screen -dmS minerProxy
    sleep 0.2s
    screen -r minerProxy -p 0 -X stuff "cd /root/miner_proxy"
    screen -r minerProxy -p 0 -X stuff $'\n'
    screen -r minerProxy -p 0 -X stuff "./run.sh"
    screen -r minerProxy -p 0 -X stuff $'\n'

    sleep 3s
    cat /root/miner_proxy/password.txt
    echo "请输入 cat /root/miner_proxy/password.txt 账号密码"
    echo "输入 cat /root/miner_proxy/后台地址.txt 查看后台地址和端口"
    echo "已启动web后台 您可运行 screen -r minerProxy 查看程序输出"
}

start() {
    if screen -list | grep -q "minerProxy"; then
        echo -e "minerProxy已启动,请勿重复启动" && exit 1
    fi
    screen -dmS minerProxy
    sleep 0.2s
    screen -r minerProxy -p 0 -X stuff "cd /root/miner_proxy"
    screen -r minerProxy -p 0 -X stuff $'\n'
    screen -r minerProxy -p 0 -X stuff "./run.sh"
    screen -r minerProxy -p 0 -X stuff $'\n'

    echo "minerProxy已启动"
    echo "您可以使用指令screen -r minerProxy查看程序输出"
}

restart() {
    if screen -list | grep -q "minerProxy"; then
        screen -X -S minerProxy quit
    fi
    screen -dmS minerProxy
    sleep 0.2s
    screen -r minerProxy -p 0 -X stuff "cd /root/miner_proxy"
    screen -r minerProxy -p 0 -X stuff $'\n'
    screen -r minerProxy -p 0 -X stuff "./run.sh"
    screen -r minerProxy -p 0 -X stuff $'\n'

    echo "minerProxy 重新启动成功"
    echo "您可运行 screen -r minerProxy 查看程序输出"
}

stop() {
    if screen -list | grep -q "minerProxy"; then
        screen -X -S minerProxy quit
    fi
    echo "minerProxy 已停止"
}

change_limit(){
    num="n"
    if [ $(grep -c "root soft nofile" /etc/security/limits.conf) -eq '0' ]; then
        echo "root soft nofile 102400" >>/etc/security/limits.conf
        num="y"
    fi

    if [[ "$num" = "y" ]]; then
        echo "连接数限制已修改为102400,重启服务器后生效"
    else
        echo -n "当前连接数限制："
        ulimit -n
    fi
}

check_limit(){
    echo -n "当前连接数限制："
    ulimit -n
}

echo "======================================================="
echo "Char1esOrz的minerProxy 一键工具"
echo "  1、安装(默认安装到/root/minerProxy)"
echo "  2、卸载"
echo "  3、更新"
echo "  4、启动"
echo "  5、重启"
echo "  6、停止"
echo "  7、解除linux系统连接数限制(需要重启服务器生效)"
echo "  8、查看当前系统连接数限制"
#echo "  9、配置开机启动"
echo "======================================================="
read -p "$(echo -e "请选择[1-8]：")" choose
case $choose in
1)
    install
    ;;
2)
    uninstall
    ;;
3)
    update
    ;;
4)
    start
    ;;
5)
    restart
    ;;
6)
    stop
    ;;
7)
    change_limit
    ;;
8)
    check_limit
    ;;
*)
    echo "输入错误请重新输入！"
    ;;
esac
