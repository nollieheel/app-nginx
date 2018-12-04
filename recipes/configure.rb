#
# Author:: Earth U (<iskitingbords@gmail.com>)
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

directory(node['app-nginx']['priv_dir']) { recursive true }

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

( node['app-nginx']['basic_auth'] || [] ).each do |e|
  template e[:path] do
    source    'htpasswd.erb'
    mode      0644
    sensitive true
    variables(
      :creds => e[:creds]
    )
  end
end
