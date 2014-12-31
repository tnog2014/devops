#
# Cookbook Name:: create-deploy-user
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
group 'deploy' do
  group_name 'deploy'
  gid     403
  action  :create
end

user 'deploy' do
  comment 'deploy'
  uid     403
  group   'deploy'
  home    '/home/deploy'
  shell   '/bin/bash'
  password 'deploy'
  supports :manage_home => true
  action  [:create, :manage]
end
