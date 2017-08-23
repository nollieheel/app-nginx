#
# Author:: Earth U (<iskitingbords @ gmail.com>)
# Cookbook Name:: app-nginx
# Attribute:: default
#
# Copyright (C) 2017, Earth U
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

default['app-nginx']['conf_dir'] = "#{node['nginx']['dir']}/sites-available"
default['app-nginx']['priv_dir'] = "#{node['nginx']['dir']}/private"

default['app-nginx']['dh_modulus'] = 4096
default['app-nginx']['dhparam_path'] =
  "#{node['app-nginx']['priv_dir']}/dhparam.pem" # set to false to disable

default['app-nginx']['sites'] = [
  # Given the default config template, here are the
  # possible template variables and their defaults:
  #{
    # Required. Name of server.
    # Can be space-separated string.
    #
    #:server_name => 'example.com',

    # Required. SSL/TLS config.
    #
    #:ssl => {
    #  :certificate     => '/path/to/certificate',
    #  :certificate_key => '/path/to/key',
    #  :dhparam         => node['app-nginx']['dhparam_path'],
    #  :cipher_suite    => 'medium', # either 'medium' or 'modern'
    #},

    # Optional. For :listen_options, string 'ssl' will 
    # always be added as first element
    #
    #:port           => 443,
    #:listen_options => [],

    # Optional. Array of hashes. Example:
    #    [ {
    #      :name => 'myupstream',
    #      :servers => [
    #        '127.0.0.1:9000',
    #        'unix:/var/run/php-fpm.sock'
    #      ]
    #    } ]
    #
    #:upstreams = nil,

    # Optional. Additional headers to be included in server responses.
    # Default values:
    #
    #:add_headers => {
    #  'Strict-Transport-Security'         => '"max-age=15758000;"',
    #  'X-Frame-Options'                   => 'SAMEORIGIN',
    #  'X-Content-Type-Options'            => 'nosniff',
    #  'X-XSS-Protection'                  => '"1; mode=block"',
    #  'X-Permitted-Cross-Domain-Policies' => 'none'
    #},

    # Optional. Location of document root.
    #
    #:doc_root => nil,

    # Optional. Index file of site, if applicable.
    #
    #:index => nil,

    # Optional. For basic auth configuration, if used. Example:
    #    {
    #      :msg            => 'Restricted Area. Please authenticate.',
    #      :user_file_path => "#{node['app-nginx']['priv_dir']}/mysite.htpasswd"
    #    }
    #
    #:auth => nil

    # Optional. Log options is an array of strings.
    #
    #:access_log_options => nil,
    #:log_dir            => node['nginx']['log_dir'],

    # Optional. Locations that are not logged if accessed.
    #
    #:nolog_locations => ['= /favicon.ico', '= /robots.txt'],

    # Optional. Locations that are not publicly accessible.
    #
    #:deny_locations => ['~ (^|/)\.'],

    # Optional. Array of static file extensions. When these files are
    # accessed, nginx will include a maximum expiry header, and not
    # log the access. When not given, the defaults are assumed. To
    # disable, set to boolean false. Default:
    #
    #:handle_static_files => %w{
    #  js css ogg ogv svg svgz eot otf woff mp4 ttf rss atom
    #  jpg jpeg gif png ico zip tgz gz rar bz2
    #  doc xls exe ppt tar mid midi wav bmp rtf
    #},

    # Optional. An array of strings that will be included as statements
    # in the main 'server' scope of the config.
    #
    #:server_statements_1 => [],

    # Optional. An array of strings that will be included as statements
    # in the main 'server' scope of the config.
    #
    #:server_statements_2 => [],

    # Optional. An array of strings that will be included as statements
    # outside of the main 'server' scope of the config, i.e. in
    # the 'http' scope.
    #
    #:http_statements => [],

    # Optional. Config template source can be customized.
    #
    #:cookbook => 'app-nginx',
    #:source   => 'nginx_site.conf.erb',
  #}
]

# For creating basic auth htpasswd files, if desired.
default['app-nginx']['basic_auth'] = [
#  {
#    :path => "#{node['app-nginx']['priv_dir']}/mysite.htpasswd",
#    :creds => [ {
#      :user => 'myuser',
#      :pass => 'secretpasswd'
#    } ]
#  }
]

default['nginx']['version']             = '1.13.4'
default['nginx']['install_method']      = 'package'
default['nginx']['package_name']        = 'nginx'
default['nginx']['repo_source']         = 'nginx'
default['nginx']['upstream_repository'] =
  'http://nginx.org/packages/mainline/ubuntu'
# Set pid file initially in accordance with Ubuntu 14.04 
# nginx package's pid file. Otherwise, it fails to restart.
default['nginx']['pid']                  = '/var/run/nginx.pid'
default['nginx']['default_site_enabled'] = false

default['nginx']['client_max_body_size']    = '10m'
default['nginx']['client_body_buffer_size'] = '64k'
default['nginx']['keepalive_timeout']       = 15
default['nginx']['keepalive_requests']      = 200

default['nginx']['event']        = 'epoll'
default['nginx']['multi_accept'] = true

# Setting worker_processes to 'auto' will automatically
# set the value to the number of CPUs. But we're going to 
# set it to twice that.
default['nginx']['worker_processes']     =
  ( %x(grep ^processor /proc/cpuinfo | wc -l).to_i ) * 2
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
