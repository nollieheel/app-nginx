#
# Cookbook:: app_nginx
# Recipe:: default
#
# Copyright:: 2021, Earth U

vs = node[cookbook_name]
apt_update if platform_family?('debian')

nginx_install 'nginx' do
  source     'repo'
  repo_train 'mainline'
end

nginx_config 'nginx' do
  default_site_enabled false
  process_user         vs['process_user']
  process_group        vs['process_group']
  worker_processes     vs['worker_processes']
  worker_connections   vs['worker_connections']
  sendfile             vs['sendfile']
  tcp_nopush           vs['tcp_nopush']
  tcp_nodelay          vs['tcp_nodelay']
  keepalive_timeout    vs['keepalive_timeout']
  conf_cookbook        vs['conf_cookbook']
  conf_variables       vs['conf_variables']
  notifies             :reload, 'nginx_service[nginx]', :delayed
end

nginx_service 'nginx' do
  action         :enable
  delayed_action :start
end

vs['auth_file'].each do |a|
  app_nginx_auth_file a[:auth_file] do
    users a[:users]
  end
end
