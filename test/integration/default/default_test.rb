# # encoding: utf-8

describe dh_params('/etc/nginx/private/dhparam.pem') do
  it { should be_dh_params }
  it { should be_valid }
  its('generator') { should eq 2 }
  its('prime_length') { should eq 1024 }
end

describe http('http://localhost', auth: {user: 'test', pass: 'password'}) do
  its('status') { should eq 200 }
  its('body') { should eq 'A webserver test' }
end
