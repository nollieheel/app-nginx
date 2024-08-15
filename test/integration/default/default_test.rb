# Accessing node attributes
p = json('/tmp/kitchen_chef_node.json').params

adef = p['default'].key?('app_nginx') ? p['default']['app_nginx'] : {}
anor = p['normal'].key?('app_nginx') ? p['normal']['app_nginx'] : {}
aove = p['override'].key?('app_nginx') ? p['override']['app_nginx'] : {}
av   = (adef.merge(anor)).merge(aove)

tdef = p['default'].key?('test') ? p['default']['test'] : {}
tnor = p['normal'].key?('test') ? p['normal']['test'] : {}
tove = p['override'].key?('test') ? p['override']['test'] : {}
tv   = (tdef.merge(tnor)).merge(tove)

describe systemd_service('nginx.service') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end

basicuser = av['auth_file'][0]['users'][0]['user']
basicpass = av['auth_file'][0]['users'][0]['pass']
describe http('http://localhost', auth: { user: basicuser, pass: basicpass }) do
  its('status') { should eq 200 }
  its('body') { should eq 'Hello World' }
end

describe file('/etc/logrotate.d/nginx') do
  its('content') { should match %r{/var/log/nginx/\*\.log} }
  its('content') { should match /create 640 #{av['process_user']} adm/ }
end

describe directory('/var/log/nginx') do
  its('owner') { should eq av['process_user'] }
  its('group') { should eq 'adm' }
end

describe file('/var/log/nginx/access.log') do
  its('owner') { should eq av['process_user'] }
  its('group') { should eq 'adm' }
  its('mode') { should cmp '0640' }
end

describe file('/var/log/nginx/error.log') do
  its('owner') { should eq av['process_user'] }
  its('group') { should eq 'adm' }
  its('mode') { should cmp '0640' }
end

describe file(tv['access_log']) do
  its('owner') { should eq av['process_user'] }
  its('group') { should eq 'adm' }
  its('mode') { should cmp '0640' }
end

describe file(tv['error_log']) do
  its('owner') { should eq av['process_user'] }
  its('group') { should eq 'adm' }
  its('mode') { should cmp '0640' }
end
