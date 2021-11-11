#
# Cookbook:: app_nginx
# Resource:: auth_file
#
# Copyright:: 2021, Earth U
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

unified_mode true

property :path, String,
         description: 'Path to the basic auth file',
         name_property: true

# Example :users property:
#    [{ user: 'john', pass: 'secret' }]
property :users, Array,
         description: 'Array of user-pass hashes.',
         default: []

action :create do
  template new_resource.path do
    cookbook 'app_nginx'
    source   'htpasswd.erb'
    mode     '0640'
    variables(
      users: new_resource.users
    )
  end
end

action :delete do
  file new_resource.path do
    action :delete
  end
end
