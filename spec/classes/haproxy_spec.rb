require 'spec_helper'

describe 'haproxy', :type => :class do
  let(:pre_condition) { '$concat_basedir = "/tmp"' }
  let (:params) {
    {
      :config_dir => '/etc/haproxy'
    }
  }

  describe 'on Debian without parameters' do
    let (:facts) { debian_facts }

    it { should create_class('haproxy') }
    it { should include_class('haproxy::install') }
    it { should include_class('haproxy::config') }
    it { should include_class('haproxy::service') }

    it { should contain_package('haproxy').with_ensure('present') }
    it { should contain_file('/etc/haproxy/haproxy.cfg').with_ensure('present') }
    it { should contain_file('/etc/default/haproxy').with_ensure('present') }

    it { should contain_service('haproxy').with(
        'ensure'     => 'running',
        'enable'     => 'true',
        'hasrestart' => 'true'
      )
    }
  end

  describe 'on Debian with parameter: config_dir' do
    let (:facts) { debian_facts }
    let (:params) { { :config_dir => '_VALUE_' } }

    it { should contain_file('_VALUE_').with_ensure('directory') }
  end
end

