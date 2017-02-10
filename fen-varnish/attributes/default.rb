#
# Cookbook:: fen-varnish
# Attributes:: default
#
# All rights reserved prashant.sharma@tothenew.com - Do Not Redistribute
#

default['varnish']['configure']['vcl_template']['variables'] = {
  config: {
    backend_host: '10.0.3.125',
    backend_port: '80'
  }
}

default['varnish']['configure']['config']['listen_port']=80

default['varnish']['configure']['config']['storage']='malloc'

default['varnish']['configure']['config']['malloc_size']='0.5G'


default['varnish']['configure']['config']['parameters']={ 'thread_pools' => '1',
  'thread_pool_min' => '100',
  'thread_pool_max' => '2500',
  'thread_pool_timeout' => '300' }
