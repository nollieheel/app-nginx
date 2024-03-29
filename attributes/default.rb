#
# Cookbook:: app_nginx
# Attribute:: default
#
# Copyright:: 2022, Earth U
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

cb = 'app_nginx'

# Attributes fed directly as properties to nginx_config resource:
default[cb]['process_user']        = 'www-data'
default[cb]['process_group']       = 'www-data'
default[cb]['worker_processes']    = 'auto'
default[cb]['worker_connections']  = 1_024
default[cb]['sendfile']            = 'on'
default[cb]['tcp_nopush']          = 'on'
default[cb]['tcp_nodelay']         = 'on'
default[cb]['keepalive_timeout']   = 60
default[cb]['types_hash_max_size'] = 2_048
default[cb]['conf_cookbook']       = cb
default[cb]['conf_template']       = 'nginx.conf.erb'
default[cb]['conf_variables']      = {
  server_tokens:             'off',
  keepalive_requests:        500,
  client_body_buffer_size:   '64k',
  client_max_body_size:      '10m',
  reset_timedout_connection: 'on',
}

default[cb]['auth_file'] = [
  # To create a basic auth file automatically,
  # follow these example values:
  # {
  #   :auth_file => '/etc/nginx/.htpasswd',
  #   :users     => [
  #     {user: 'john', pass: 'secret'},
  #     {user: 'jane', pass: 'password'},
  #   ]
  # }
]

# The following is an example set of variables to
# be passed to nginx_site resource call
# using the default site-template.erb template file.
#
# example_site_vars = {
#   maps: [{
#     source: '$host',
#     target: '$mycustomvar',
#     mapping: [
#       { key: 'example.com', val: 'example' },
#       { key: 'www.example.com', val: 'example-www' },
#     ],
#   }],
#
#   upstreams: [{
#     name:    'myupstream',
#     servers: %w(server1 server2),
#   }],
#
#   server_name:  'mysite.com www.mysite.com',
#   root_dir:     '/var/www/mysite',
#   log_filename: 'mysite',
#
#   locations: [{
#     location_string: '/',
#     statements: [
#       'try_files $uri /app.php$is_args$args',
#     ],
#   }],
#
#   lb_ranges: %w(
#     172.31.1.0/24 172.31.2.0/24
#     172.31.3.0/24 172.31.4.0/24
#   ),
#
#   client_max_body_size: '25M',
#   keepalive_timeout:    10,
#
#   others: [],
# }
