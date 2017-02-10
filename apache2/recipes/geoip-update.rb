#
# Cookbook Name:: fen-apache2
# Recipe:: geoip2-update
#
# Copyright 2015, FEN
#
# All rights reserved - Do Not Redistribute
#

####including the apt default recipe to use apt_repository resource
include_recipe 'apt::default'

# Add the MaxMind PPA repo
apt_repository 'maxmind' do
  uri          'ppa:maxmind/ppa'
  distribution node['lsb']['codename']
end

# Delete the GeoIP.conf file bef
if File.exists?('/etc/GeoIP.conf')
  file '/etc/GeoIP.conf' do
    action :delete
  end
end

# Install geoipupdate
package 'geoipupdate' do
  action :install
  options '--force-yes'
end

# Install the geoip CLI utilities
package 'geoip-bin' do
  action :install
end

# Set up the GeoIP conf file with the license data
template '/etc/GeoIP.conf' do
  source 'GeoIP.conf.erb'
  owner 'root'
  group node['root_group']
  mode '0644'
end

# Create the database if it doesn't exist
execute 'geoipupdate' do
  action :run
  command <<-EOF
  /usr/bin/geoipupdate
  chmod -R +r /usr/share/GeoIP
  EOF
end

