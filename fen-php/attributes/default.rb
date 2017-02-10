#
# Cookbook:: fen-php
# Attributes:: default
#
# All rights reserved prashant.sharma@tothenew.com - Do Not Redistribute
#

default['pm']['type']='dynamic'
default['pm']['max_children']='5'
default['pm']['start_servers']='2'
default['pm']['min_spare_servers']='1'
default['pm']['max_spare_servers']='3'

default['php']['install_method'] = 'source'

default['php']['include_path'] = %w[/site/vendor /site/lib /site/html /usr/share/pear /usr/share/php]

default['php']['modules'] = {
  'php5-curl' => true,
  'php5-gd' => true, 
  'php5-geoip' => true,
  'php5-gmp' => true, 
  'php5-imap' => true,
  'php5-intl' => true,
  'php5-ldap' => true, 
  'php5-memcache' => true, 
  'php5-mcrypt' => true,
  'php5-mhash' => true,
  'php5-mongo' => true,
  'php5-mysql' => true,
  'php5-pgsql' => true,
  'php5-pspell' => true,
  'php5-sqlite' => true,
  'php5-xdebug' => false,
  'php5-xhprof' => false
}

default['php']['directives']['date.timezone'] = 'UTC'
default['php']['directives']['short_open_tag'] = 'Off'
default['php']['directives']['error_log'] = '/var/log/php-scripts.log'
default['php']['directives']['max_execution_time'] = '300'
default['php']['directives']['memory_limit'] = '1024M'

default['php']['apache2']['conf_dir'] = `dirname #{node['php']['conf_dir']}`.strip + '/apache2'

  # Set up configurations for Zend OpCache
default['php']['config']['opcache']['config_file'] = "#{node['php']['apache2']['conf_dir']}/conf.d/05-opcache.ini"
default['php']['config']['opcache']['template'] = 'opcache.ini.erb'
default['php']['config']['opcache']['conf'] = {
  'enable' => 1,
  'enable_cli' => 1,
  'opcache.validate_timestamps' => 5,
  'opcache.use_cwd' => 1,
  'opcache.memory_consumption' => 192,
  'opcache.max_accelerated_files' => 20000,
  'opcache.interned_strings_buffer' => 32,
  'opcache.revalidate_freq' => 0,
  'opcache.fast_shutdown' => 1
}

# Set up configurations for APCu
default['php']['config']['php5-apcu']['template'] = 'apcu.ini.erb'
default['php']['config']['php5-apcu']['conf'] = {
  'apc.enabled' => 1,
  'apc.shm_size' => '8M',
  'apc.ttl' => 7200,
  'apc.gc_ttl' => 3660,
  'apc.enable_cli' => 1,
  'apc.entries_hint' => 4096
}
