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

    echo "请选择测试版还是稳定版"
    echo "  1、v3稳定版"
    echo "  2、v4测试版"
    read -p "$(echo -e "请输入[1-2]：")" choose
    case $choose in
    1)
        wget https://cdn.jsdelivr.net/gh/Char1esOrz/minerProxy@master/release/v3.0.3/minerProxy_web -O /root/miner_proxy/minerProxy
        ;;
    2)
        wget https://cdn.jsdelivr.net/gh/Char1esOrz/minerProxy@master/release/v4.0.0T7/minerProxy_v4.0.0T7_linux_amd64 -O /root/miner_proxy/minerProxy
        ;;
    *)
        echo "请输入正确的数字"
        ;;
    esac
    chmod 777 /root/miner_proxy/minerProxy

    wget https://cdn.jsdelivr.net/gh/Char1esOrz/minerProxy@master/scripts/run.sh -O /root/miner_proxy/run.sh
    chmod 777 /root/miner_proxy/run.sh
    echo "如果没有报错则安装成功"
    echo "正在启动..."
    ulimit -n 102400
    screen -dmS minerProxy
    sleep 0.2s
    screen -r minerProxy -p 0 -X stuff "cd /root/miner_proxy"
    screen -r minerProxy -p 0 -X stuff $'\n'
    screen -r minerProxy -p 0 -X stuff "./run.sh"
    screen -r minerProxy -p 0 -X stuff $'\n'
    sleep 1s
    cat /root/miner_proxy/config.yml
    echo "请记录您的token和端口 并打开 http://服务器ip:端口 访问web服务进行配置"
    echo "已启动web后台 您可运行 screen -r minerProxy 查看程序輸出"
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
    echo "请选择测试版还是稳定版"
    echo "  1、稳定版"
    echo "  2、测试版"
    read -p "$(echo -e "请输入[1-2]：")" choose
    case $choose in
    1)
        wget https://cdn.jsdelivr.net/gh/Char1esOrz/minerProxy@master/release/v3.0.3/minerProxy_web -O /root/miner_proxy/minerProxy
        ;;
    2)
        wget https://cdn.jsdelivr.net/gh/Char1esOrz/minerProxy@master/release/v4.0.0T7/minerProxy_v4.0.0T7_linux_amd64 -O /root/miner_proxy/minerProxy
        ;;
    *)
        echo "请输入正确的数字"
        ;;
    esac
    chmod 777 /root/miner_proxy/minerProxy

    echo "v3和v4版本配置文件不通用,如果您为v3升级为v4或v4回退至v3,请删除配置文件"
    read -p "是否删除配置文件[yes/no]：" flag
    if [ -z $flag ]; then
        echo "输入错误" && exit 1
    else
        if [ "$flag" = "yes" -o "$flag" = "ye" -o "$flag" = "y" ]; then
            rm -rf /root/miner_proxy/config.yml
            echo "删除配置文件成功"
        fi
    fi
    ulimit -n 102400
    screen -dmS minerProxy
    sleep 0.2s
    screen -r minerProxy -p 0 -X stuff "cd /root/miner_proxy"
    screen -r minerProxy -p 0 -X stuff $'\n'
    screen -r minerProxy -p 0 -X stuff "./run.sh"
    screen -r minerProxy -p 0 -X stuff $'\n'

    sleep 1s
    cat /root/miner_proxy/config.yml
    echo "请记录您的token和端口 并打开 http://服务器ip:端口 访问web服务进行配置"
    echo "已启动web后台 您可运行 screen -r minerProxy 查看程序輸出"
}

start() {
    if screen -list | grep -q "minerProxy"; then
        echo -e "minerProxy已启动,请勿重复启动" && exit 1
    fi
    ulimit -n 102400
    screen -dmS minerProxy
    sleep 0.2s
    screen -r minerProxy -p 0 -X stuff "cd /root/miner_proxy"
    screen -r minerProxy -p 0 -X stuff $'\n'
    screen -r minerProxy -p 0 -X stuff "./run.sh"
    screen -r minerProxy -p 0 -X stuff $'\n'

    echo "minerProxy已启动"
    echo "您可以使用指令screen -r minerProxy查看程序輸出"
}

restart() {
    if screen -list | grep -q "minerProxy"; then
        screen -X -S minerProxy quit
    fi
    ulimit -n 102400
    screen -dmS minerProxy
    sleep 0.2s
    screen -r minerProxy -p 0 -X stuff "cd /root/miner_proxy"
    screen -r minerProxy -p 0 -X stuff $'\n'
    screen -r minerProxy -p 0 -X stuff "./run.sh"
    screen -r minerProxy -p 0 -X stuff $'\n'

    echo "minerProxy 重新启动成功"
}

stop() {
    if screen -list | grep -q "minerProxy"; then
        screen -X -S minerProxy quit
    fi
    echo "minerProxy 已停止"
}

echo "======================================================="
echo "Char1esOrz的minerProxy 一键工具"
echo "  1、安  装(默认安装到/root/minerProxy)"
echo "  2、卸  载"
echo "  3、更  新"
echo "  4、启  动"
echo "  5、重  启"
echo "  6、停  止"
#echo "  7、配置开机启动"
echo "======================================================="
read -p "$(echo -e "请选择[1-6]：")" choose
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
*)
    echo "输入错误请重新输入！"
    ;;
esac
