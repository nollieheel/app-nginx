#
# Cookbook:: test
# Attribute:: default
#
# Copyright:: 2021, Earth U

default['test']['auth_file'] = '/etc/nginx/.htpasswd'
default['test']['auth_user'] = 'tester'
default['test']['auth_pass'] = 'password'

default['test']['user'] = 'nginx'
default['test']['group'] = node['test']['user']
default['test']['root_dir'] = '/var/www/local'
