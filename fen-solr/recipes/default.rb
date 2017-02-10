#
# Cookbook Name:: fen-solr
# Recipe:: default
#
# Copyright (c) 2017 prashant.sharma@tothenew.com, All Rights Reserved.

##### Installing Java 8
node.override['java']['jdk_version'] = '8'
node.override['java']['install_flavor'] = 'oracle'
node.override['java']['oracle']['accept_oracle_download_terms'] = true

include_recipe 'solr'

file '/etc/init.d/solr' do
      action :delete
end

cookbook_file "/opt/solr-#{node['solr']['version']}/bin/solr" do
  source 'solr'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

link "/etc/init.d/solr" do
  to "/opt/solr-#{node['solr']['version']}/bin/solr"
end

service 'solr' do
  supports :restart => true, :status => true
  action [:enable, :start]
end

include_recipe 'fen-solr::nginx'
