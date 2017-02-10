#
# Cookbook Name:: fen-solr
# Recipe:: nginx
#
# Copyright (c) 2017 prashant.sharma@tothenew.com, All Rights Reserved.


package 'nginx'

include_recipe 'htpasswd'

htpasswd "/etc/nginx/htpasswd.users" do
  user "solradmin"
  password "S0Lr@AdMiN"
end

template '/etc/nginx/sites-available/solr' do
  source 'nginx.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

link "/etc/nginx/sites-enabled/solr" do
  to "/etc/nginx/sites-available/solr"
end

service "nginx" do
  action :restart
end
