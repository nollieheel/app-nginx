#
# Author:: Earth U (<iskitingbords@gmail.com>)
# Cookbook Name:: test
# Recipe:: default
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

include_recipe 'app-nginx'

nginx_site 'test_site' do
  template  'site.conf.erb'
  variables(
    :auth => {
      :msg => 'Basic auth needed',
      :path_pass => "#{node['app-nginx']['priv_dir']}/test.htpasswd"
    }
  )
end
