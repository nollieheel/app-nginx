#
# Cookbook:: app_nginx
# Resource:: log_perms
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

require 'pathname'
cb = 'app_nginx'

unified_mode true

# Nginx process user in Ubuntu defaults to 'nginx'.
#
# If that user is modified (e.g. to 'www-data'), then both the logrotate config
# and the existing log file ownerships have to be changed as well.

# Seems like there is a small delay before a site config is fully generated
# through the nginx_site resource, and the site's initial log files are
# created. Running app_nginx_log_perms immediately after may not affect them,
# that's why this property exists, to force the creation of those
# initial log files.
#
# Example:
#   [
#     'access.log', 'error.log',
#     'mydomain.com.access.log', 'mydomain.com.error.log',
#   ]
property :initial_log_files, Array,
         description: 'List of log filenames to be initialized '\
                      'in the :log_location dirname.',
         default: ['access.log', 'error.log']

property :log_location, String,
         description: 'Path to Nginx log files',
         default: '/var/log/nginx/*.log'

property :owner, String,
         description: "Owner of log files. Group will always be 'adm'. "\
                      "Defaults to node['app_nginx']['process_user']."

property :pid_file, String,
         description: 'Location of Nginx PID file',
         default: '/var/run/nginx.pid'

property :log_config_location, String,
         description: 'Location of logrotate config file',
         default: '/etc/logrotate.d/nginx'

action :fix do
  puser = if property_is_set?(:owner)
            new_resource.owner
          else
            node[cb]['process_user']
          end

  new_resource.initial_log_files.each do |f|
    fname = Pathname.new(f).absolute? ? ::File.basename(f) : f
    file "#{::File.dirname(new_resource.log_location)}/#{fname}" do
      mode  '0640'
      owner puser
      group 'adm'
    end
  end

  execute 'fix_log_perms' do
    command "chown -R #{puser}:adm #{new_resource.log_location} "\
            "&& chmod -R 640 #{new_resource.log_location}"
  end

  template new_resource.log_config_location do
    cookbook cb
    source   'logrotate.erb'
    variables(
      log_location: new_resource.log_location,
      owner:        puser,
      pid_file:     new_resource.pid_file
    )
  end
end
