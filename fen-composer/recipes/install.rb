#
# Cookbook Name:: fen-composer
# Recipe:: install
#
# Copyright (c) 2017 prashant.sharma@tothenew.com, All Rights Reserved.


include_recipe 'composer'

composer_package "#{node['drush']['dir']}" do
    action :install
end
