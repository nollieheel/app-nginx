#
# Cookbook:: app_nginx
# Recipe:: default
#
# Copyright:: 2024, Earth U
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

vs = node[cookbook_name]

nginx_install 'nginx' do
  source     'repo'
  repo_train 'mainline'
end

# override repo listing

file '/etc/apt/sources.list.d/nginx.list' do
  action :delete
end

add_apt 'nginx-mainline' do
  keyserver    false
  key          'https://nginx.org/keys/nginx_signing.key'
  key_dearmor  true
  uri          'https://nginx.org/packages/mainline/ubuntu'
  distribution node['lsb']['codename']
  components   ['nginx']
  deb_src      true
end

nginx_config 'nginx' do
  default_site_enabled false
  process_user         vs['process_user']
  process_group        vs['process_group']
  worker_processes     vs['worker_processes']
  worker_connections   vs['worker_connections']
  sendfile             vs['sendfile']
  tcp_nopush           vs['tcp_nopush']
  tcp_nodelay          vs['tcp_nodelay']
  keepalive_timeout    vs['keepalive_timeout']
  types_hash_max_size  vs['types_hash_max_size']
  conf_cookbook        vs['conf_cookbook']
  conf_template        vs['conf_template']
  conf_variables       vs['conf_variables']
  notifies             :reload, 'nginx_service[nginx]', :delayed
end

nginx_service 'nginx' do
  action         :enable
  delayed_action :start
end

vs['auth_file'].each do |a|
  app_nginx_auth_file a[:auth_file] do
    users a[:users]
  end
end
