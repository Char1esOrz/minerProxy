#!/bin/bash
[[ $(id -u) != 0 ]] && echo -e "请在root权限下运行" && exit 1
while true; do
    ./minerProxy
done
