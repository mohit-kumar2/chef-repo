#
# Cookbook Name:: fen-apache2
# Recipe:: configure
#
# Runs as default configure step for apache2
#
# Copyright 2016, FEN
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'cron'

cron_d 'compress-web-logs' do
  minute '15'
  hour '0'
  command "find #{node['apache']['log_dir']} -ctime +0 -exec gzip {} +"
  cookbook 'cron'
  mailto 'system-alerts-learning@fen.com'
end

env = { AWS_DEFAULT_REGION: 'us-east-1' }
if node.has_key?('opsworks')
  instance_id = node["opsworks"]["instance"]["aws_instance_id"]
else
  instance = search("aws_opsworks_instance", "self:true").first
  instance_id = instance['ec2_instance_id']
end
  
cron_d 'archive-web-logs' do
  minute '45'
  hour '0'
  environment env
  path "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
  command "for f in #{node['apache']['log_dir']}/*.gz; do aws s3 mv --quiet $f s3://sandbox-co-weblogs/#{instance_id}/ ; done"
  cookbook 'cron'
  mailto 'system-alerts-learning@fen.com'
end

# Set up the GeoIP update cron job in /etc/cron.d*****  
cron_d 'geoipupdate' do
  minute '0'
  hour '12'
  weekday '3'
  command "sleep $[RANDOM/10]; /usr/bin/geoipupdate 2>&1 | tee /tmp/geoipupdate.log | egrep -v '^(MD5 Digest of installed database|.* up to date|Updating|Updated)' | /usr/bin/ifne /bin/mail -s 'GeoIP update problem' karl.debisschop@fen.com; chmod -R +r /usr/share/GeoIP"
end

# Send report when city file is not readable  
cron_d 'check-geoip-permissions' do
  minute '*'
  hour '*'
  command "test -r /usr/share/GeoIP/GeoIPCity.dat || echo `ls -l /usr/share/GeoIP` | mail -s 'permissions failed on GeoIPCity.dat' system-alerts@fen.com"
  user node['apache']['user']
end

# Make sure City file is readable  
cron_d 'reset-geoip-permissions' do
  minute '*'
  hour '*'
  command "sleep 1;chmod -R +r /usr/share/GeoIP"
end
