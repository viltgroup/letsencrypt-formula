describe file('/etc/letsencrypt/cli.ini') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_readable }
    its('size') { should be > 1 }
end
