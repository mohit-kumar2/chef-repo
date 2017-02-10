#
# Cookbook:: fen-logrotate
# Recipe:: varnish
#
# Copyright:: 2017, mohit.kumar@tothenew.com, All Rights Reserved.

logrotate_app 'varnish' do
  path      '/var/log/varnish/*.log'
  frequency 'daily'
  rotate    7
  options   ['missingok', 'compress', 'delaycompress', 'notifempty', 'sharedscripts']
  create    '640 root adm'
  postrotate "/bin/kill -HUP `cat /var/run/varnishlog.pid 2>/dev/null` 2> /dev/null || true
           
  BUCKET=\"s3://fen-rotated-logs\"
  ENVIRONMENT=\"#{node['environment']}\"
  APPLICATION=\"apache\" 
LOGS_PATH=\"/var/log/varnish\"

/usr/bin/aws s3 sync  \"$LOGS_PATH\"/ \"$BUCKET\"/\"$ENVIRONMENT\"/\"$APPLICATION\"/ --exclude \"*\" --include \"*.gz\" --region us-east-1"
  
end

