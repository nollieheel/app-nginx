#
# Cookbook:: app_nginx
# Resource:: log_perms
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

unified_mode true

# Can be a filesystem wildcard such as: '/var/log/nginx/*.log'
property :log_location, String,
         description: 'Location of Nginx log files',
         name_property: true

property :owner, String,
         description: "Owner of log files. Group will always be set to 'adm'.",
         default: 'nginx'

property :pid_file, String,
         description: 'Nginx PID file',
         default: '/var/run/nginx.pid'

property :log_config_location, String,
         description: 'Location of logrotate config file',
         default: '/etc/logrotate.d/nginx'

property :initial_log_files, Array,
         description: 'Optional list of log files to be initialized '\
                      'in the log_location.',
         default: []

action :fix do

  new_resource.initial_log_files.each do |f|
    file "#{::File.dirname(new_resource.log_location)}/#{f}" do
      mode  '0640'
      owner new_resource.owner
      group 'adm'
    end
  end

  execute 'fix_log_perms' do
    command "chown -R #{new_resource.owner}:adm #{new_resource.log_location} "\
            "&& chmod -R 640 #{new_resource.log_location}"
  end

  template new_resource.log_config_location do
    cookbook 'app_nginx'
    source   'logrotate.erb'
    variables(
      log_location: new_resource.log_location,
      owner: new_resource.owner,
      pid_file: new_resource.pid_file,
    )
  end
end
