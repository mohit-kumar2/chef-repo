#
# Cookbook Name:: fen-sonarqube
# Recipe:: default
#
# Copyright (c) 2017 prashant.sharma@tothenew.com, All Rights Reserved.

##### Installing Java 8
node.override['java']['jdk_version'] = '8'
node.override['java']['install_flavor'] = 'oracle'
node.override['java']['oracle']['accept_oracle_download_terms'] = true

include_recipe 'java::default'

include_recipe 'sonarqube::default'
