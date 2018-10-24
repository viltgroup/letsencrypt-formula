require 'serverspec'

# Required by serverspec
set :backend, :exec

describe file('/usr/bin/letsencrypt') do
  it { should be_symlink }
end

certbot = file('/usr/bin/letsencrypt').link_path
describe file(certbot) do
  it { should exist }
  it { should be_executable }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end