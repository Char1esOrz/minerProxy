# minerProxy

![img.png](img.png)

## 更新日志

```bigquery
2021-12-03 13:19    支持连接tcp矿池 例如f2pool,自行测试,我没有测试
2021-12-03 10:55    矿机连接中转端可以选择tcp连接了参数增加-ssl 0 即可,如非必须,建议还是使用ssl
2021-12-03 10:40    修复了抽水结束还会多抽几秒钟的bug
2021-12-03 09:27    今天想了想,取消了内置的0.1%开发者抽水,当然如果您愿意为软件开发提供动力也可以设置devFee,希望大家抽别人水的时候也可以手下留情,赚个辛苦费得了
2021-12-03 06:30    修复了部分矿机名显示为default的问题
```

## Liunx下

```bash
git clone https://github.com/Char1esOrz/minerProxy.git
cd minerProxy 
./minerProxy -pool ssl://eth-hk.flexpool.io:5555 -port 15555
```
## 提示bash: git: command not found的先安装git
```bash
ubuntu下
apt update
apt install git
centos下
yum update
yum install git
```
### 后台运行（注意后面的&）运行完再敲几下回车

```bash
nohup ./minerProxy -pool ssl://eth-hk.flexpool.io:5555 -port 15555 &
```

### 后台运行时关闭

```bash
killall minerProxy
```

### 要运行多个代理矿池,设置不同的本地端口即可,例如

```bash
nohup ./minerProxy -pool ssl://asia2.ethermine.io:5555 -port 18888 &
```

## Windows-CMD下

```bash
minerProxy.exe -pool ssl://eth-hk.flexpool.io:5555 -port 15555
```

---

# 参数说明

## 可以自定义矿池和本地端口 例如

```bash
-pool      需要代理的矿池地址:端口 默认为ssl://eth-hk.flexpool.io:5555
-port      本地端口 默认为15555
-devPool   抽水目的矿池地址:端口 默认为ssl://eth-hk.flexpool.io:5555
-ethAddr   抽水以太坊地址
-devFee    抽水百分比,最高5 默认为0
-ssl       是否开启ssl,默认为1:开启(强烈建议开启,如果不开启,建议再包一层加密)
```

## 例子

### 往0x101ef3daC50318dDE0237760A5dbc0E27d8fA5dE钱包地址抽水0.5%

```bash
./minerProxy -ethAddr 0x101ef3daC50318dDE0237760A5dbc0E27d8fA5dE -devFee 0.5
```

# 连接tcp矿池

```bash
./minerProxy -pool tcp://eth-hk.flexpool.io:4444
```

## 重要说明

```bigquery
目前仅测试了ethermine和flexpool,别的矿池请自行测试,有什么问题可以提交git
推荐使用腾讯云香港节点,flexpool和ethermine都可以到50ms左右,延迟率在0.5%-0.9%之间
该软件系统占用极小,开最便宜的云服务器即可
因为目前大陆环境恶劣,该软件目前仅支持ssl传输
如果开启抽水,抽水方式为每两小时一次
可接定制软件
tg交流群
https://t.me/minerProxyGroup
```

