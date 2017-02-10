#
# Cookbook Name:: fen-apache2
# Recipe:: vhosts
#
# Copyright (c) 2017 prashant.sharma@tothenew.com, All Rights Reserved.
#

node.override['apache']['dir'] = '/etc/apache2'
node.override['apache']['docroot']='/var/www/html'

node['domains'].each do |domain|
apache_docroot = "/fensite/public_html/docroot"
directory "#{apache_docroot}" do
  owner 'www-data'
  group 'www-data'
  mode '0755'
  recursive true
  action :create
end

web_app "#{domain['value']}" do
      template "#{domain['value']}.conf.erb"
      server_name "#{domain['value']}"
      docroot "#{apache_docroot}"
   end
 apache_site "#{domain['value']}" do
   enable true
   notifies :restart, 'service[apache2]', :immediately
 end
end
