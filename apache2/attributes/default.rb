#
# Cookbook:: fen-apache2
# Attributes:: default
#
# All rights reserved prashant.sharma@tothenew.com - Do Not Redistribute
#

node.normal['apache']['status_allow_list'] = "10.0.0.0/16"
  
node.normal['apache']['access_log'] = 'access.%Y%m%d'

node.normal['apache']['error_log'] = 'errors.%Y%m%d'
node.normal['apache']['log_pipe'] = '|/usr/bin/rotatelogs -l '
node.normal['apache']['log_pipe_rotation'] = ' 86400'
