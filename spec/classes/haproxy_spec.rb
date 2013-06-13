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

  describe 'on Debian with parameter: config_dir_mode' do
    let (:facts) { debian_facts }
    let (:params) { { :config_dir => '_VALUE_', :config_dir_mode => '_VALUE_' } }

    it { should contain_file('_VALUE_').with_mode('_VALUE_') }
  end

  describe 'on Debian with parameter: config_dir_recurse' do
    let (:facts) { debian_facts }
    let (:params) { { :config_dir => '_VALUE_', :config_dir_recurse => '_VALUE_' } }

    it { should contain_file('_VALUE_').with_recurse('_VALUE_') }
  end

  describe 'on Debian with parameter: config_file_mode' do
    let (:facts) { debian_facts }
    let (:params) { { :config_dir => '_VALUE_', :config_file_mode => '_VALUE_' } }

    it { should contain_file('_VALUE_/haproxy.cfg').with_mode('_VALUE_') }
  end

  describe 'on Debian with parameter: config_group' do
    let (:facts) { debian_facts }
    let (:params) { { :config_dir => '_VALUE_', :config_group => '_VALUE_' } }

    it { should contain_file('_VALUE_').with_group('_VALUE_') }
  end

  describe 'on Debian with parameter: config_purge' do
    let (:facts) { debian_facts }
    let (:params) { { :config_dir => '_VALUE_', :config_purge => true } }

    it { should contain_file('_VALUE_').with_purge(true) }
  end

  describe 'on Debian with parameter: config_user' do
    let (:facts) { debian_facts }
    let (:params) { { :config_dir => '_VALUE_', :config_user => '_VALUE_' } }

    it { should contain_file('_VALUE_').with_owner('_VALUE_') }
  end

  #describe 'on Debian with parameter: daemon_group' do
  #  let (:facts) { debian_facts }
  #  let (:params) { { :daemon_group => '_VALUE_' } }
  #
  #  it { should contain_file('/etc/default/basemodule').with_content(/_VALUE_/) }
  #end

  #describe 'on Debian with parameter: daemon_user' do
  #  let (:facts) { debian_facts }
  #  let (:params) { { :daemon_user => '_VALUE_' } }
  #
  #  it { should contain_file('/etc/default/basemodule').with_content(/_VALUE_/) }
  #end

  describe 'on Debian with parameter: log_dir' do
    let (:facts) { debian_facts }
    let (:params) { { :log_dir => '_VALUE_' } }

    it { should contain_file('_VALUE_').with_ensure('directory') }
  end

#  describe 'on Debian with parameter: pkg_ensure' do
#    let (:facts) { debian_facts }
#    let (:params) { { :pkg_ensure => '_VALUE_' } }
#
#    it { should contain_package('basemodule').with_ensure('_VALUE_') }
#  end
#
#  describe 'on Debian with parameter: pkg_list' do
#    let (:facts) { debian_facts }
#    let (:params) { { :pkg_list => '_VALUE_' } }
#
#    it { should contain_package('_VALUE_') }
#  end
#
#  describe 'on Debian with parameter: service_enable' do
#    let (:facts) { debian_facts }
#    let (:params) { { :service_enable => '_VALUE_' } }
#
#    it { should contain_service('basemodule').with_enable('_VALUE_') }
#  end
#
#  describe 'on Debian with parameter: service_ensure' do
#    let (:facts) { debian_facts }
#    let (:params) { { :service_ensure => '_VALUE_' } }
#
#    it { should contain_service('basemodule').with_ensure('_VALUE_') }
#  end
#
#  describe 'on Debian with parameter: service_hasstatus' do
#    let (:facts) { debian_facts }
#    let (:params) { { :service_hasstatus => '_VALUE_' } }
#
#    it { should contain_service('basemodule').with_hasstatus('_VALUE_') }
#  end
#
#  describe 'on Debian with parameter: service_name' do
#    let (:facts) { debian_facts }
#    let (:params) { { :service_name => '_VALUE_' } }
#
#    it { should contain_service('_VALUE_') }
#  end
end

