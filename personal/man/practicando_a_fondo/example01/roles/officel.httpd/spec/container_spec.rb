require 'spec_helper'

describe file('/etc/httpd') do
  it { should be_directory }
end

describe file('/etc/httpd/conf') do
  it { should be_directory }
end

describe file('/etc/httpd/conf.d') do
  it { should be_directory }
end

describe file('/var/log/httpd') do
  it { should be_mode 755 }
end


describe file('/etc/logrotate.d') do
  it { should be_directory }
end

describe file('/etc/logrotate.d/httpd') do
  it { should be_file }
end

describe service('httpd') do
  it { should be_enabled }
end

