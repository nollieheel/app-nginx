#
# Cookbook:: test
# Recipe:: default
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

# So Inspec can use node attributes
ruby_block 'save node attribs' do
  block do
    ::File.write('/tmp/kitchen_chef_node.json', node.to_json)
  end
end

vs = node[cookbook_name]

include_recipe 'app_nginx'

directory vs['root_dir'] do
  mode      '0755'
  recursive true
  notifies  :create, 'file[index]', :immediately
end

file 'index' do
  path    "#{vs['root_dir']}/index.html"
  content 'Hello World'
  mode    '0644'
  action  :nothing
end

nginx_site 'test_site' do
  cookbook cookbook_name
  variables(
    root_dir:   vs['root_dir'],
    auth_file:  node['app_nginx']['auth_file'][0]['auth_file'],
    access_log: vs['access_log'],
    error_log:  vs['error_log']
  )
end

app_nginx_log_perms 'logs' do
  initial_log_files [
    'access.log',
    'error.log',
    vs['access_log'],
    vs['error_log'],
  ]
end
