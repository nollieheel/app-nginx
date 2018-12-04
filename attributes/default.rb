#
# Author:: Earth U (<iskitingbords@gmail.com>)
# Cookbook Name:: app-nginx
# Attribute:: default
#
# Copyright (C) 2018, Earth U
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['app-nginx']['priv_dir'] = "#{node['nginx']['dir']}/private"

default['app-nginx']['dhparam_path'] =
  "#{node['app-nginx']['priv_dir']}/dhparam.pem" # set to false to disable
default['app-nginx']['dh_modulus'] = 4096

default['app-nginx']['basic_auth'] = [
## Example:
#  {
#    :path => "#{node['app-nginx']['priv_dir']}/mysite.htpasswd",
#    :creds => [ {
#      :user => 'myuser',
#      :pass => 'secretpasswd'
#    } ]
#  }
]

# Use ubuntu mainline versions. The 'version' attribute
# is basically unused here. Whatever is latest on the repo is installed.
default['nginx']['version']             = '1.13.8'
default['nginx']['install_method']      = 'package'
default['nginx']['package_name']        = 'nginx'
default['nginx']['repo_source']         = 'nginx'
default['nginx']['upstream_repository'] =
  'http://nginx.org/packages/mainline/ubuntu'

default['nginx']['default_site_enabled'] = false

default['nginx']['client_max_body_size']    = '10m'
default['nginx']['client_body_buffer_size'] = '64k'
default['nginx']['keepalive_timeout']       = 15
default['nginx']['keepalive_requests']      = 200

default['nginx']['event']        = 'epoll'
default['nginx']['multi_accept'] = false

# Setting worker_processes to 'auto' will automatically
# set the value to the number of CPUs. But we add 1 to that.
default['nginx']['worker_processes']     =
  ( %x(grep ^processor /proc/cpuinfo | wc -l).to_i ) + 1
# Either use `ulimit -n` (usually 1024) for worker_connections, or
# set it to a much higher value, but not exceeding worker_rlimit_nofile.
default['nginx']['worker_connections']   = 10000
default['nginx']['worker_rlimit_nofile'] = 15000

default['nginx']['disable_access_log'] = false
default['nginx']['server_tokens']      = 'off'
default['nginx']['gzip_comp_level']    = '5'
default['nginx']['extra_configs']      = {
  'reset_timedout_connection' => 'on'
}

# Increase this to 128 if using super long server names
default['nginx']['server_names_hash_bucket_size'] = 64
