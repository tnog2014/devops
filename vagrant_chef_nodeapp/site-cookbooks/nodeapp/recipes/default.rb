#
# Cookbook Name:: nodeapp
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

bash 'add_epel' do
  user 'root'
  code <<-EOC
    rpm -ivh http://ftp.riken.jp/Linux/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm
    sed -i -e "s/enabled *= *1/enabled=1/g" /etc/yum.repos.d/epel.repo
  EOC
  creates "/etc/yum.repos.d/epel.repo"
end

# add the EPEL repo
#yum_repository 'epel' do
#  description 'Extra Packages for Enterprise Linux'
##  mirrorlist 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=$basearch'
#  mirrorlist 'https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=$basearch'
##  gpgkey 'http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6'
#   gpgkey 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6'
#  action :create
#end

cookbook_file "/etc/yum.repos.d/mongodb.repo" do
  source "mongodb.repo"
  mode 00644
end

package "mongodb-org" do
  action :install
end

service "mongod" do
  action [ :enable, :start ]
end

package "nodejs" do
  action :install
end

package "npm" do
  action :install
end

bash 'install_forever' do
  user 'root'
  code <<-EOC
    npm install -g forever  
  EOC
end
