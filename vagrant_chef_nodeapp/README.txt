# 実行方法
knife solo cook nodeapp

# Vagrantで作成した仮想マシンにsshでログインできるようにする方法
vagrant ssh-config --host nodeapp >> ~/.ssh/config

# Cookbookの作り方
knife solo cook nodeapp

# Vagrantで起動した仮想マシンをブリッジ接続して、ホストOS以外からも接続できるようにする。 
#config.vm.network "private_network", ip: "192.168.33.10"
config.vm.network :public_network, ip: "192.168.1.7", bridge: "eth0"

