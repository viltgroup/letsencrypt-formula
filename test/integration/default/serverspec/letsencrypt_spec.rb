require 'serverspec'

# Required by serverspec
set :backend, :exec

describe file('/opt/letsencrypt') do
    it { should be_directory }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_readable }
    its('size') { should be > 25 }
end