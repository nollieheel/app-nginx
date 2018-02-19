#
# Author:: Earth U (<iskitingbords @ gmail.com>)
# Cookbook Name:: app-nginx
# Recipe:: configure
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

include_recipe 'openssl::upgrade'

directory node['app-nginx']['priv_dir']

if node['app-nginx']['dhparam_path']
  openssl_dhparam node['app-nginx']['dhparam_path'] do
    key_length node['app-nginx']['dh_modulus']
    generator 2
  end
else
  file node['app-nginx']['dhparam_path'] do
    action :delete
  end
end
#
#node['app-nginx']['sites'].each do |site|
#  site_main_name = site[:server_name].split(' ')[0]
#  site_cb = site[:cookbook] || 'app-nginx'
#  site_source = site[:source] || 'nginx_site.conf.erb'
##
#  template "#{node['app-nginx']['conf_dir']}/#{site_main_name}" do
#    cookbook  site_cb
#    source    site_source
#    mode      0644
#    notifies  :restart, 'service[nginx]', :delayed
#    variables site
#  end
#
#  nginx_site site_main_name do
#    enable true
#  end
#end
