#
# Cookbook Name:: fen-varnish
# Recipe:: default
#
# Copyright (c) 2017 prashant.sharma@tothenew.com, All Rights Reserved.

node.override['varnish']['configure']['vcl_template']['source'] = 'custom.vcl.erb'
node.override['varnish']['configure']['vcl_template']['cookbook'] = 'fen-varnish'

include_recipe 'varnish::configure'
