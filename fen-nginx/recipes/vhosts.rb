#
# Cookbook Name:: fen-nginx
# Recipe:: vhosts
#
# Copyright (c) 2017 prashant.sharma@tothenew.com, All Rights Reserved.

package 'nginx'

node['domains'].each do |domain|
template "/etc/nginx/sites-available/#{domain['value']}" do
  source "#{domain['value']}.erb"
  owner  'root'
  group  node['root_group']
  mode   '0644'
  notifies :reload, 'service[nginx]', :delayed
end

link "/etc/nginx/sites-enabled/#{domain['value']}" do
  to "/etc/nginx/sites-available/#{domain['value']}"
end
end

service "nginx" do
  action :restart
end
