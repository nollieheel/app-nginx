#
# Cookbook:: app_nginx
# Resource:: auth_file
#
# Copyright:: 2021, Earth U

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
    mode     '0644'
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
