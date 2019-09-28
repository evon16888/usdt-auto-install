#安装相关依赖
sudo apt-get update
sudo apt-get install git pkg-config
sudo apt-get install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils
sudo apt-get install libboost-all-dev
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:bitcoin/bitcoin
sudo apt-get update
sudo apt-get install libdb4.8-dev libdb4.8++-dev

#下载源码包
git clone https://github.com/OmniLayer/omnicore.git
cd omnicore/
./autogen.sh
./configure & make
make install

#创建基本配置
read -p "请输入安装目录[默认/home]： " upath
if [[ -z "${uport}" ]];then
	upath="/home"
fi
mkdir -p "${upath}"/usdt/data
touch "${upath}"/usdt/usdt.conf
cat>>"${upath}"/usdt/usdt.conf<<EOF
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
EOF

#启动程序
/usr/local/bin/omnicored -conf="${upath}"/usdt/usdt.conf -datadir="${upath}"/usdt/data &

#加入开机启动
echo "/usr/local/bin/omnicored -conf="${upath}"/usdt/usdt.conf -datadir="${upath}"/usdt/data  &" >> /etc/rc.local
