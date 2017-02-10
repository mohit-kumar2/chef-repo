#
# Cookbook Name:: fen-php
# Recipe:: install
#
# Copyright (c) 2016 prashant.sharma@tothenew.com, All Rights Reserved.

require 'chef/log'
include_recipe 'apt'
package 'libpspell-dev'
include_recipe 'php'

template '/etc/init.d/php-fpm' do
  source 'php-init.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

template '/usr/local/etc/php-fpm.conf' do
  source 'php-fpm.conf.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

%w(mongo redis).each do |pearpkg|
php_pear "#{pearpkg}" do
  action :install
end
end

#php_pear "apcu" do
#  version "4.0.11"
#  action :install
#end

cookbook_file '/etc/php5/cli/php.ini' do
  source 'php.ini'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

## Configure apcu
#template "/etc/php5/mods-available/apcu.ini" do
#  Chef::Log.info("Setting up apcu")
#  source 'apcu.ini.erb'
#  unless platform?('windows')
#    owner 'root'
#    group node['root_group']
#    mode '0644'
#  end
#end

# Configure opcache
template "/etc/php5/mods-available/05-opcache.ini" do
  Chef::Log.info("Setting up opcache")
  source 'opcache.ini.erb'
  unless platform?('windows')
    owner 'root'
    group node['root_group']
    mode '0644'
  end
end

service 'php-fpm' do
  action :start
end
