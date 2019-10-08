#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# 安装wget
yum -y install wget

# 下载USDT安装包
wget https://bintray.com/artifact/download/omni/OmniBinaries/omnicore-0.5.0-x86_64-linux-gnu.tar.gz

# 解包
tar -zvxf omnicore-0.5.0-x86_64-linux-gnu.tar.gz

# 安装在bin目录下
install -m 0755 -o root -g root -t /usr/local/bin ./omnicore-0.5.0/bin/*

# 在根目录创建配置文件目录
mkdir ~/.bitcoin

# 创建目录
mkdir /www/coin/usdt_data

# 创建配置文件
touch ~/.bitcoin/bitcoin.conf
# 写入文件
cat>>~/.bitcoin/bitcoin.conf<<EOF
server=1  
txindex=1 
rpcuser=rpcuser
rpcpassword=123456
rpcallowip=0.0.0.0/0 
rpcport=8332
paytxfee=0.00001
minrelaytxfee=0.00001
datacarriersize=80
logtimestamps=1
omnidebug=tally  
omnidebug=packets
omnidebug=pending
datadir=/www/coin/usdt_data
EOF

# 启动USDT
/usr/local/bin/omnicored &
