#
# Cookbook:: test
# Recipe:: default
#
# Copyright:: 2021, Earth U

vs = node[cookbook_name]

include_recipe 'app_nginx'

app_nginx_auth_file vs['auth_file'] do
  users [{
    user: vs['auth_user'],
    pass: vs['auth_pass'],
  }]
end

directory vs['root_dir'] do
  owner     vs['user']
  group     vs['group']
  mode      '0755'
  recursive true
  notifies  :create, 'file[index]', :immediately
end

file 'index' do
  path    "#{vs['root_dir']}/index.html"
  content 'Hello World'
  owner   vs['user']
  group   vs['group']
  mode    '0644'
  action  :nothing
end

nginx_site 'test_site' do
  cookbook cookbook_name
  template 'site-template.erb'
  variables(
    root_dir:  vs['root_dir'],
    auth_file: vs['auth_file']
  )
end
