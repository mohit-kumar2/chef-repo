#
# Cookbook:: fen-solr
# Attributes:: default
#
# All rights reserved prashant.sharma@tothenew.com - Do Not Redistribute
#

default['solr']['version']  = '5.5.3'
default['solr']['checksum'] = '74e8a924dac0e073854af121a6de9d58fe8cc315d16b57e17f429c6a91b0b065'
default['solr']['url']      = "https://archive.apache.org/dist/lucene/solr/#{node['solr']['version']}/#{node['solr']['version'].split('.')[0].to_i < 4 ? 'apache-' : ''}solr-#{node['solr']['version']}.tgz"

default['solr']['java_options'] = '-Xms128M -Xmx1024M'
