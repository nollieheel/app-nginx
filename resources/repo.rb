#
# Cookbook:: app_nginx
# Resource:: repo
#
# Copyright:: 2026, Earth U
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

# Set up Nginx repo

cb = 'app_nginx'

unified_mode true

property :cache_rebuild, [true, false],
         description: 'Automatically update cache after adding repo',
         default: true

property :key, String,
         description: 'Location of repo key',
         default: 'https://nginx.org/keys/nginx_signing.key'

property :key_checksum, String,
         default: '55385da31d198fa6a5012d40ae98ecb272a6c4e8fffffba94719ffd3e87de37a'

property :uri, String,
         description: 'Repo URI',
         default: 'https://nginx.org/packages/mainline/ubuntu'

action :configure do
  unless %w(24.04 26.04).include?(node['platform_version'])
    raise "app_nginx_repo supports only Ubuntu 24.04 and 26.04 (found: #{node['platform_version']})"
  end

  tmp_key = "#{Chef::Config[:file_cache_path]}/nginx_signing.key"

  remote_file tmp_key do
    source   new_resource.key
    checksum new_resource.key_checksum
  end

  key_array = ::File.readlines(tmp_key, chomp: true)

  template '/etc/apt/sources.list.d/nginx.sources' do
    cookbook cb
    variables(
      uri:           new_resource.uri,
      suite:         node['lsb']['codename'],
      raw_key_array: key_array
    )
  end

  template '/etc/apt/preferences.d/99nginx' do
    cookbook cb
  end

  apt_update 'app_nginx' do
    action :update
  end if new_resource.cache_rebuild
end
