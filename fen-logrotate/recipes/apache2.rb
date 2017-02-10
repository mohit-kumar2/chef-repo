#
# Cookbook Name:: fen-logrotate
# Recipe:: apache2
#
# Copyright (c) 2017 prashant.sharma@tothenew.com, All Rights Reserved.

logrotate_app 'apache2' do
  path      '/var/log/apache2/*.log'
  frequency 'daily'
  rotate    7
  options   ['missingok', 'compress', 'delaycompress', 'notifempty', 'sharedscripts']
  create    '640 root adm'
  postrotate " if /etc/init.d/apache2 status > /dev/null ; then
                   /etc/init.d/apache2 reload > /dev/null;
               fi;
  BUCKET=\"s3://fen-rotated-logs\"
  ENVIRONMENT=\"#{node['environment']}\"
  APPLICATION=\"apache\"
 
LOGS_PATH=\"/var/log/apache2\"
/usr/bin/aws s3 sync  \"$LOGS_PATH\"/ \"$BUCKET\"/\"$ENVIRONMENT\"/\"$APPLICATION\"/ --exclude \"*\" --include \"*.gz\" --region us-east-1"
  prerotate 'if [ -d /etc/logrotate.d/httpd-prerotate ]; then
run-parts /etc/logrotate.d/httpd-prerotate;
fi;'
end
