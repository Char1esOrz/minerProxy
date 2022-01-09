# minerProxy
![img_5.png](img/img_5.png)
![img_6.png](img/img_6.png)
## 更新日志
```bigquery
2022-01-09 16:51    4.0.0T1>>>
                    4.0.0测试版1 代码重构 稍后更新一键安装和自启动脚本,303稳定用户可以先观望一段时间
                    已知bug 在抽水池为e池时抽水份额会不够，正式版会修复这个问题，测试用户使用f池进行测试即可
2021-12-27 19:16    3.0.3>>>修复了内存溢出的问题,强烈建议3.0.X和2.6.X系列用户升级
2021-12-26 00:02    3.0.2>>>继续修复有的矿机掉线后无法连接或不断开连接的问题
                    建议3.0.X版本升级到此版本

2021-12-26 00:02    3.0.1
                    1. 修复了有的矿机掉线后无法连接或不断开连接的问题
                    2. 修复了部分人蚂蚁矿池无法连接的问题
                    建议3.0.0版本升级到此版本

2021-12-25 10:02    3.0.0>>>代码重构,经过了单机1600台压力测试

2021-12-24 00:30    2.6.6T2>>>修复若干bug

2021-12-23 11:17    2.6.5>>>增加了web版本,优化部分代码

2021-12-23 08:07    2.6.4>>>代码优化,提升稳定性

2021-12-22 03:06    2.6.3>>>修复了poolin提交算力会把算力提交到一个矿机上的问题
                            增加了config版本,配置好config直接启动即可

2021-12-21 18:39    2.6.2>>>增加了-clientNum参数 限制最大矿机连接数,可以防止cc攻击

2021-12-21 18:39    2.6.1>>>可能修复了部分矿池崩溃问题

2021-12-21 03:03    2.6.0>>>
                    1.大幅提升稳定性。
                    2.对ethermine,f2pool,poolin,2miners,ezil,nanopool进行了深度优化。（必须使用官方域名节点,否则程序不知道）
                    3.显示矿池延迟
                    4.抽水百分比现在会按照份额难度换算后呈现
                    5.增加了防DNS污染

2021-12-16 19:06    2.5.7>>>增加了两个参数
                    -reConnect 矿池多久不下发任务重连 默认10秒
                    -config 从yml配置文件启动默认为空
                    说明文档增加了linux下后台运行如何查看和linux下如何更新软件的代码,不会的小伙伴可以看一下
                    修复了在ok 币安 蚂蚁矿池下用户名错误导致崩溃的bug

2021-12-15 14:09    2.5.6>>>稳如老狗版

目前的抽水方式为随机抽水,算力曲线不会像心电图那样,更加合理
2.5.5以上版本可以查看抽水的份额了(ps:当代理矿池和抽水矿池不一样时需要根据矿池算力自己算一下百分比)
```

## Liunx下

```bash
git clone https://github.com/Char1esOrz/minerProxy.git
cd minerProxy 
./minerProxy -pool ssl://asia2.ethermine.org:5555 -port 15555
```

### 后台运行（注意后面的&）运行完再敲几下回车

```bash
nohup ./minerProxy -pool ssl://asia2.ethermine.org:5555 -port 15555 &
```

### 后台运行时关闭

```bash
killall minerProxy
```
### 后台运行时查看
```bash
tail -f nohup.out
```
### 更新软件
```bash
git pull 
```
### 要运行多个代理矿池,设置不同的本地端口即可,例如

```bash
nohup ./minerProxy -pool ssl://asia2.ethermine.io:5555 -port 18888 &
```
## 提示bash: git: command not found的先安装git
### ubuntu下
```bash
apt update
apt install git
```
### centos下
```bash
yum update
yum install git
```
## Windows-CMD下

```bash
minerProxy.exe -pool ssl://asia2.ethermine.org:5555 -port 15555
```

---

# 参数说明
![img_1.png](img/img_1.png)
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
推荐使用腾讯云香港节点,flexpool和ethermine都可以到50ms左右,延迟率在0.5%-0.9%之间
该软件系统占用极小,开最便宜的云服务器即可
可接定制软件
tg交流群
https://t.me/minerProxyGroup
```

![img_2.png](img/img_2.png)

